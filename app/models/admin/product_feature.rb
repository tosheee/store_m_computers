class Admin::ProductFeature < ActiveRecord::Base
  validates :category_id, presence: true
            #:sub_category_id, :identifier, :description
end
