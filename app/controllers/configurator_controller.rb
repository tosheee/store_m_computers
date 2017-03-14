class ConfiguratorController < ApplicationController

  def configurator
     @fans = Admin::ProductFeature.where(sub_category_id: 6)
     @cpus = Admin::ProductFeature.where(sub_category_id: 7)
     @mainboards = Admin::ProductFeature.where(sub_category_id: 8)
     @video_cards = Admin::ProductFeature.where(sub_category_id: 9)
     @cases = Admin::ProductFeature.where(sub_category_id: 10)
     @hard_disks = Admin::ProductFeature.where(sub_category_id: 11)
     @rams = Admin::ProductFeature.where(sub_category_id: 12)
  end
end
