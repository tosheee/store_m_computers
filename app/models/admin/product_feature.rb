class Admin::ProductFeature < ActiveRecord::Base

  has_many :order_items
  #default_scope { where(active: true) }

  validates :category_id, :description, presence: true
            # :sub_category_id, :identifier, :description
            # validates :category_id, presence: true
end
