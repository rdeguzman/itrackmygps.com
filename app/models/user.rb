class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:username]

  has_many :devices

  validates :email, presence: true
  validates_format_of :email, :with => Devise::email_regexp

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }

  validates :password, presence: true, confirmation: true, :length => {:within => 8..128}
end
