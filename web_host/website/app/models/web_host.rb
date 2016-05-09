class WebHost

  def self.build_default
    web_gpg_key_hash = Settings.web_gpg_key.to_h
    return if web_gpg_key_hash.blank?

    gpg_key_pub_asc = web_gpg_key_hash[:public_asc]
    gpg_key_id = web_gpg_key_hash[:id]

    local_gpg_keys = GPGME::Key.find(:secret, gpg_key_id)
    if local_gpg_keys.blank?
      gpg_key_pub_asc = File.read(Rails.root.join("spec/data/gpg_keys/#{gpg_key_id}.key.pub_asc").to_s)
      gpg_key_priv_asc = File.read(Rails.root.join("spec/data/gpg_keys/#{gpg_key_id}.key.priv_asc").to_s)

      GPGME::Key.import(gpg_key_pub_asc)
      GPGME::Key.import(gpg_key_priv_asc)
    end

  end

end
