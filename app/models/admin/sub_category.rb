class Admin::SubCategory < ActiveRecord::Base
  validates :category_id, :name, :identifier, presence: true
end
