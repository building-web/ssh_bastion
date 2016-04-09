class AccountSshKey < ApplicationRecord

  extend Enumerize
  attr_accessor :key

  CAT_ARRAY = [
    :'ssh-rsa',
    :'ssh-dsa',
  ]

  enumerize :cat, in: CAT_ARRAY

  belongs_to :account

  validates :content, uniqueness: { case_sensitive: true }

  before_validation :scan_key, if: Proc.new { |a| a.key.present? }

  private
  def scan_key
    # TODO
    cat, content, comment = key.scan(/[\w'-]+/)
  end
end
