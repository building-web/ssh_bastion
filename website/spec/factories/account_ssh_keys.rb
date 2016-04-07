FactoryGirl.define do

  factory :account_ssh_key do
    association :account, factory: :user
    title { FFaker::Lorem.sentence }

    initialize_with do
      k = SSHKey.generate comment: FFaker::Internet.email
      cat, content, comment = k.ssh_public_key.split(' ')

      new cat: cat, content: content, comment: comment
    end

  end

end
