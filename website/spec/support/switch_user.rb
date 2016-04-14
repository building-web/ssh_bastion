require 'rspec/core'

module SwitchUser
  module RSpecFeatures

    def switch_user(user_record_or_scope, user_id=nil)
      case user_record_or_scope
      when ActiveRecord::Base
        user_scope = user_record_or_scope.model_name.singular.to_sym

        unless SwitchUser.available_scopes.include?(user_scope)
          raise "don't allow this user sign in, please check config.available_users"
        end

        identifier = SwitchUser.available_users_identifiers[user_scope]
        if identifier.nil?
          raise "don't allow this user sign in, please check config.available_users_identifiers"
        end

        user_id = user_record_or_scope.send identifier
      else
        user_scope = user_record_or_scope
      end

      scope_identifier = "#{user_scope}_#{user_id}"

      visit "/switch_user?scope_identifier=#{scope_identifier}"
    end

  end
end



RSpec.configure do |config|

  config.include SwitchUser::RSpecFeatures, type: :feature

  config.before do
    allow_any_instance_of(SwitchUserController).to receive(:available?).and_return true
  end

end
