class AssignedHost < ApplicationRecord
  belongs_to :account
  belongs_to :host
end
