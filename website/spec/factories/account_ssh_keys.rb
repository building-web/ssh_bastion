FactoryGirl.define do

  sequence :account_ssh_key_title do |n|
    "title%s" % n
  end

  factory :account_ssh_key do
    association :account, factory: :user
    title { generate :account_ssh_key_title }

    initialize_with do
      k = SSHKey.generate comment: FFaker::Internet.email
      _, _, comment = k.ssh_public_key.split(' ')

      new key: k.ssh_public_key, comment: comment
    end

  end

end
