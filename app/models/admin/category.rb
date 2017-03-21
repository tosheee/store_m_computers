class Admin::Category < ActiveRecord::Base
  validates :name_cat, presence: true
end
