require 'rails_helper'

RSpec.describe AccountsHostUserPolicy, type: :policy do

  subject { described_class }

  permissions :index? do
    let(:account) { create(:account) }
    let(:host) { create(:host) }

    it "denies access if account was not has_ssh_key" do
      allow(account).to receive(:has_ssh_key?).and_return(false)
      expect(subject).not_to permit(account, host)
    end

    it "denies access if account was not enabled_two_factor_authentication" do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(false)
      expect(subject).not_to permit(account, host)
    end

    it "grants access if account was has_ssh_key and enabled_two_factor_authentication" do
      allow(account).to receive(:has_ssh_key?).and_return(true)
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      expect(subject).to permit(account, host)
    end
  end
end
