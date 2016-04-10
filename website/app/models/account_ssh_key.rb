class AccountSshKey < ApplicationRecord

  extend Enumerize

  attr_accessor :key

  CAT_ARRAY = [
    :'ssh-rsa',
    :'ssh-dsa',
  ]

  enumerize :cat, in: CAT_ARRAY

  belongs_to :account

  validates :title, presence: true
  validates :content, presence: true, uniqueness: { case_sensitive: true }

  def public_key
    key = "%s %s" % [cat, content]
    if comment.present?
      key << " #{comment}"
    end
    key
  end

  def fingerprint
    SSHKey.fingerprint public_key
  end

  def key=(key_content)
    if key_content.blank?
      return errors.add(:key, :blank)
    end

    unless SSHKey.valid_ssh_public_key?(key_content)
      return errors.add(:key, :invalid)
    end

    self.cat, self.content, self.comment = parse_key(key_content)
  end

  private

  def parse_key(key_content)
    key_content.split(' ')
  end

end
