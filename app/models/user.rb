class User < ActiveRecord::Base
  before_create :generate_access_token

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:username]

  has_many :devices

  validates :email, presence: true
  validates_format_of :email, :with => Devise::email_regexp

  validates :username, presence: true, :length => {:within => 6..128}
  validates :username, uniqueness: true, if: -> { self.username.present? }
  #only allow nny word character (letter, number, underscore)
  validates_format_of :username, :with => /\A[\w]*\z/

  validates :password, presence: true, confirmation: true, :length => {:within => 8..128}

  validate :pin_length, :pin_numeric

  def pin_length
    if pin and pin.length != 4
      errors.add(:pin, "must be 4 digits")
    end
  end

  def pin_numeric
    if pin and (pin =~ /\A\d+\z/).nil?
      errors.add(:pin, "must be 4 numeric characters only")
    end
  end

  def generate_access_token
    self.access_token = SecureRandom.hex
  end
end
