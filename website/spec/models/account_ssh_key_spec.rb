require 'rails_helper'

RSpec.describe AccountSshKey, type: :model do

  subject { create :account_ssh_key }

  describe "public instance methods" do
    context "responds to its methods" do
      it { expect(subject).to respond_to(:public_key) }
      it { expect(subject).to respond_to(:fingerprint) }
    end

    context "#public_key" do
      it "when comment blank" do
        account_ssh_key = build :account_ssh_key, comment: ''

        ssh_public_key = "%s" % account_ssh_key.key

        expect(account_ssh_key.public_key).to eq(ssh_public_key)
      end

      it "when comment present" do
        account_ssh_key = build :account_ssh_key, comment: 'abc@example.com'

        ssh_public_key = "%s abc@example.com" % account_ssh_key.key

        expect(account_ssh_key.public_key).to eq(ssh_public_key)
      end
    end

    context "#fingerprint" do
      it "when public_key correct" do
        account_ssh_key = build :account_ssh_key

        ssh_public_key = generate_ssh_public_key
        allow(account_ssh_key).to receive(:public_key).and_return(ssh_public_key)

        expect(account_ssh_key.fingerprint).to eq(ssh_public_key_fingerprint(ssh_public_key))
      end
    end

  end

  describe "private instance methods" do
    context "#parse_key" do
      it "when comment blank" do
        key_content = generate_ssh_public_key('RSA', '')

        result = subject.send(:parse_key, key_content)
        expect(result[0]).to eq('ssh-rsa')
        expect(key_content).to include(result[1])
        expect(result[2]).to eq(nil)
      end

      it "when comment present" do
        key_content = generate_ssh_public_key('RSA', 'abc@example.com')

        result = subject.send(:parse_key, key_content)
        expect(result[0]).to eq('ssh-rsa')
        expect(key_content).to include(result[1])
        expect(result[2]).to eq('abc@example.com')
      end
    end
  end

end
