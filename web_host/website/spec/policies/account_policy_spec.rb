require 'rails_helper'

RSpec.describe AccountPolicy, type: :policy do

  subject { described_class }

  permissions :enabled_two_factor_authentication? do
    let(:account) { create(:account) }

    it 'denies access if account enabled two factor authentication' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      expect(subject).not_to permit(account)
    end

    it 'grants access if account has no enabled two factor authentication' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(false)
      expect(subject).to permit(account)
    end
  end

  permissions :recovery_codes? do
    let(:account) { create(:account) }

    it 'denies access if account not enabled two factor authentication otp_backup_codes_downloaded_at true' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(false)
      allow(account).to receive(:otp_backup_codes_downloaded_at).and_return(nil)
      expect(subject).not_to permit(account)
    end

    it 'grants access if account has enabled two factor authentication otp_backup_codes_downloaded_at true' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      allow(account).to receive(:otp_backup_codes_downloaded_at).and_return('Mon, 18 Apr 2016 19:40:32 CST +08:00')

      expect(subject).not_to permit(account)
    end

    it 'grants access if account has enabled two factor authentication otp_backup_codes_downloaded_at flase' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      allow(account).to receive(:otp_backup_codes_downloaded_at).and_return(nil)

      expect(subject).to permit(account)
    end
  end

  permissions :new? do
    let(:account) { create(:account) }

    it 'denies access if account not enabled two factor authentication false but role is admin' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(false)
      allow(account).to receive(:role?).with(:admin).and_return(true)

      expect(subject).not_to permit(account)
    end

    it 'grants access if account has enabled two factor authentication true but role is not admin' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      allow(account).to receive(:role?).with(:admin).and_return(false)

      expect(subject).not_to permit(account)
    end

    it 'grants access if account has enabled two factor authentication true and is admin' do
      allow(account).to receive(:enabled_two_factor_authentication?).and_return(true)
      allow(account).to receive(:role?).with(:admin).and_return(true)

      expect(subject).to permit(account)
    end
  end

end
