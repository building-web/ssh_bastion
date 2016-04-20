#deivse initial user
class User
  has_many :cards

  attribute :name, String
  attribute :phone, String
  attribute :address, String
  attribute :type
end

class Admin < User
end

class Doctor < User
  has_one :doctor_profile
  has_many :notifications
  has_many :payments
  has_many :consultations
end

class Patient < User
  has_one :patient_profile
  has_many :notifications
  has_many :payments
  has_many :consultations
end

class DoctorProfile
  belongs_to :doctor
  has_many :appointment_times
  has_many :notifications

  attribute :avatar, String
  attribute :specialities, Integer

  attribute :status, Integer(avaliable: 1, Unavaliable: 2, deciline: 3)
end

class PatientProfile
  belongs_to :patient

  attribute :age, Integer
end

class AppointmentTime
  belongs_to :doctor
  attribute :price, Decimal
end

class Notifications
  belongs_to :doctor
  belongs_to :patient

  attribute :read, Boolean
end

class Card
  belongs_to :user

  attribute :card_type, Integer
  attribute :no, String
  attribute :email, String
  attribute :venc, String
  attribute :cvc, String
  attribute :exp_month, String
  attribute :exp_year, String
end

class Checkout
  belongs_to :doctor
  belongs_to :patient
  belongs_to :card
  has_many :consultations

  attribute :currency, Decimal
  attribute :status, Integer(success: 1, refund: 2)
end

class Consultations
  belongs_to :patient
  belongs_to :doctor

  attribute :consult_from, Date
  attribute :consult_end, Date
end