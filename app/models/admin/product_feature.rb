class Admin::ProductFeature < ActiveRecord::Base
  #validates :category_id, presence: true
  validates :category_id, :description, presence: true
            #:sub_category_id, :identifier, :description
end
