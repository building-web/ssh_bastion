class HostUser < ApplicationRecord

  belongs_to :host
  validate :check_name

  private
  def check_name
    return errors.add(:name, "can not be same as 'root'") if name == 'root'
  end
end
