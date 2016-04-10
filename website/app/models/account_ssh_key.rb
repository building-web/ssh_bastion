class AccountSshKey < ApplicationRecord

  extend Enumerize

  belongs_to :account

  validates :title, presence: true, uniqueness: {scope: :account_id}
  validates :key, presence: true, uniqueness: {}
  validate :validate_key

  def public_key
    _key = key
    if comment.present?
      _key << " #{comment}"
    end
    _key
  end

  def fingerprint
    SSHKey.fingerprint public_key
  end

  private

  def validate_key
    unless SSHKey.valid_ssh_public_key?(key)
      return errors.add(:key, :invalid)
    end

    _, _, self.comment = parse_key(key)
  end

  def parse_key(key_content)
    key_content.split(' ')
  end

end
