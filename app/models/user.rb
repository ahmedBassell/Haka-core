class User < ApplicationRecord
  include ::Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # TODO Override :validatable to validate phone instead of email
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :lockable,
          :trackable,
          :jwt_authenticatable,
          jwt_revocation_strategy: self

  has_one :kaha_profile
  has_many :events
  has_many :conversations
  has_many :participants
  has_many :messages
  has_one_attached :avatar
  
  enum role: ::ROLES_MAP
  enum gender: ::GENDER_MAP

  def avatar_url
    return unless avatar.attachment.present?

    avatar.variant(resize_to_limit: [100, 100]).processed.url
  end
end
