class Event < ApplicationRecord
  include ::Discard::Model
  enum category: ::EVENT_CATEGORYS_MAP
  
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  belongs_to :canceled_by, class_name: "User", foreign_key: "canceled_by_id", optional: true
  has_many :event_participants, dependent: :destroy, foreign_key: "event_id"
  has_many_attached :images

  def canceled?
    self.canceled_at.present?
  end

  def images_urls
    return unless images.attachments.present?

    images.map{|image| image.variant(resize_to_limit: [300, 300]).processed.url }
  end
end
