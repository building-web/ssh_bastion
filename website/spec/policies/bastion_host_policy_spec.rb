require 'rails_helper'

RSpec.describe BastionHostPolicy, type: :policy do

  subject { described_class }

  permissions :index? do
    let(:account) { create(:account) }
    let(:bastion_host) { create(:bastion_host) }

    it "denies access if account not has role admin" do
      allow(account).to receive(:role?).with(:admin).and_return(false)
      expect(subject).not_to permit(account, bastion_host)
    end

    it "grants access if account has role admin" do
      allow(account).to receive(:role?).with(:admin).and_return(true)
      expect(subject).to permit(account, bastion_host)
    end

  end

end
