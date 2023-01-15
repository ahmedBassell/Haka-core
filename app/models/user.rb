class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable

  has_one :kaha_profile
  has_many :events
  
  enum role: ::ROLES_MAP
  enum gender: ::GENDER_MAP
end
