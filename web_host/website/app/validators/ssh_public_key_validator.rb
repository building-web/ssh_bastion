class SshPublicKeyValidator < ActiveModel::Validator

  def validate(record)
    begin
      unless SSHKey.valid_ssh_public_key?(record.key)
        record.errors.add :key, :invalid
      end
    rescue SSHKey::PublicKeyError => err
      record.errors.add :key, :invalid
    end
  end

end
