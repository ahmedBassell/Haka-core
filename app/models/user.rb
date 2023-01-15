class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # TODO Override :validatable to validate phone instead of email
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :lockable,
          :trackable

  has_one :kaha_profile
  has_many :events
  
  enum role: ::ROLES_MAP
  enum gender: ::GENDER_MAP
end
