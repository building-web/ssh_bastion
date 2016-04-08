require 'rails_helper'

RSpec.describe Account, type: :model do

  subject { create :account }

  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(subject).to respond_to(:role?) }
      it { expect(subject).to respond_to(:submitted_ssh_key?) }
      it { expect(subject).to respond_to(:enabled_two_factor_authentication?) }
    end

    context "#role?" do
      it "user's roles" do
        user = create :user
        expect(user.role?(:user)).to eq(true)
        expect(user.role?(:admin)).to eq(false)
      end

      it "admin's roles" do
        admin = create :admin
        expect(admin.role?(:user)).to eq(false)
        expect(admin.role?(:admin)).to eq(true)
      end
    end

    context "#submitted_ssh_key?" do
      it "return false" do
        user = create :user

        expect(user.submitted_ssh_key?).to eq(false)
      end

      it "return true" do
        user = create :user
        create :account_ssh_key, account: user

        expect(user.submitted_ssh_key?).to eq(true)
      end
    end

    context "#enabled_two_factor_authentication?" do
      it "return false" do
        user = create :user

        expect(user.enabled_two_factor_authentication?).to eq(false)
      end

      it "return true" do
        user = create :user_with_enabled_two_factor

        expect(user.enabled_two_factor_authentication?).to eq(true)
      end
    end

  end

end
