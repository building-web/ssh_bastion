class PublicKeyBox < ApplicationRecord

  belongs_to :public_key_boxable, polymorphic: true

  validates :title, presence: true, uniqueness: {scope: :public_key_boxable}
  validates :key, presence: true, uniqueness: {}, ssh_public_key: {}

  before_validation :sub_key_comment

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

  def sub_key_comment
    return if key.blank?

    begin
      ssh_type, encoded_key = SSHKey.send(:parse_ssh_public_key, key)
    rescue SSHKey::PublicKeyError => err
    else
      self.key = "#{ssh_type} #{encoded_key}"
    end
  end

end
