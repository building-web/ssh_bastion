require 'rails_helper'

RSpec.describe HostPolicy, type: :policy do

  subject { described_class }

  permissions :index? do
    let(:account) { create(:account) }
    let(:host) { create(:host) }

    it "denies access if secret_matched was false" do
      allow(account).to receive(:secret_matched?).and_return(false)
      expect(subject).not_to permit(account, host)
    end

    it "grants access if secret_matched was true" do
      allow(account).to receive(:secret_matched?).and_return(true)
      expect(subject).to permit(account, host)
    end
  end

  permissions :create? do
    let(:account) { create(:account) }
    let(:host) { create(:host) }

    it "denies access if secret_matched false" do
      allow(account).to receive(:secret_matched?).and_return(false)
      allow(account).to receive(:role?).with(:admin).and_return(true)
      expect(subject).not_to permit(account, host)
    end

    it "denies access if role not admin" do
      allow(account).to receive(:secret_matched?).and_return(true)
      allow(account).to receive(:role?).with(:admin).and_return(false)
      expect(subject).not_to permit(account, host)
    end

    it "grants access if secret_matched true and role admin" do
      allow(account).to receive(:secret_matched?).and_return(true)
      allow(account).to receive(:role?).with(:admin).and_return(true)
      expect(subject).to permit(account, host)
    end
  end

  permissions :update? do
    let(:account) { create(:account) }
    let(:host) { create(:host) }

    it "denies access if secret_matched false" do
      allow(account).to receive(:secret_matched?).and_return(false)
      allow(host).to receive(:creator_account).and_return(account)
      expect(subject).not_to permit(account, host)
    end

    it "denies access if role not admin" do
      allow(account).to receive(:secret_matched?).and_return(true)
      allow(host).to receive(:creator_account).and_return('false')
      expect(subject).not_to permit(account, host)
    end

    it "grants access if secret_matched true and role admin" do
      allow(account).to receive(:secret_matched?).and_return(true)
      allow(host).to receive(:creator_account).and_return(account)
      expect(subject).to permit(account, host)
    end
  end
end
