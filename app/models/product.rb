class Product < ApplicationRecord
  include Notifications

  after_create :log_new_product

  has_many :subscribers, dependent: :destroy
  has_one_attached :featured_image
  has_rich_text :description
  validates :name, presence: true

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  after_update_commit :notify_subscribers, if: :back_in_stock?

  private
    def log_new_product
      puts "A new product was added"
    end
end
