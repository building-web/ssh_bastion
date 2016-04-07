class SshKey < ApplicationRecord

  belongs_to :account

  validates :content, uniqueness: { case_sensitive: true }

end
