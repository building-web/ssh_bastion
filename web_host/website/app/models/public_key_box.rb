class PublicKeyBox < ApplicationRecord

  extend Enumerize

  CAT_HASH = {
    ssh: 1,
    gpg: 2,
  }

  enumerize :cat, in: CAT_HASH, i18n_scope: "enums.public_key_box.cat",
                      default: :ssh,
                      scope: true,
                      predicates: { prefix: true }

  belongs_to :public_key_boxable, polymorphic: true

  validates :title, presence: true, uniqueness: {scope: :public_key_boxable}
  validates :key, presence: true, uniqueness: {}
  validates :key, ssh_public_key: {}, if: :cat_ssh?

  before_validation :sub_ssh_key_comment, if: :cat_ssh?

  def public_key
    if cat_ssh?
      comment.present? ? ("%s %s" % [key, comment]) : key
    elsif cat_gpg?
      # TODO
    end
  end

  def fingerprint
    if cat_ssh?
      SSHKey.fingerprint public_key
    elsif cat_gpg?
      # TODO
    end
  end

  private

  def sub_ssh_key_comment
    return if key.blank?

    begin
      ssh_type, encoded_key = SSHKey.send(:parse_ssh_public_key, key)
    rescue SSHKey::PublicKeyError => err
    else
      self.key = "#{ssh_type} #{encoded_key}"
    end
  end

end
