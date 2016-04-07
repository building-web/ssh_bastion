module Helpers

  def generate_ssh_public_key(type='RSA', comment='test@example.com', bits=2048, passphrase=nil)
    k = SSHKey.generate(
      type:       type,
      bits:       bits,
      comment:    comment,
      passphrase: passphrase
    )

    k.ssh_public_key
  end

end

RSpec.configure do |config|

  config.include Helpers

end
