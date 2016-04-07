module AccountExtRole

  extend ActiveSupport::Concern

  included do
    extend Enumerize

    ROLE_HASH = { user: 1, admin: 9 }

    enumerize :role, in: ROLE_HASH, scope: true, predicates: { prefix: true }
  end
end