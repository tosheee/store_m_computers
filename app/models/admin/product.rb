class Admin::Product < ActiveRecord::Base
  validates :category_id, :description, presence: true
end
