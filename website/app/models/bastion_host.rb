class BastionHost < ApplicationRecord

  validates :ip, :ip => { :format => :v4 }

end
