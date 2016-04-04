class BastionHost < ApplicationRecord
  
  validates :ip, :ip => { :format => :v4 }
  validates :desc, uniqueness: { case_sensitive: false }
end
