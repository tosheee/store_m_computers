class ConfiguratorController < ApplicationController

  def configurator
     sub_cat = Admin::SubCategory.all
    @fans = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/fan/] }.join.to_i)
    @cpus = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/cpu/] }.join.to_i)
    @mainboards = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/mainboard/] }.join.to_i)
    @video_cards = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/video_card/] }.join.to_i)
    @cases = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/case/] }.join.to_i)
    @hard_disks = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/hard_disks/] }.join.to_i)
    @rams = Admin::ProductFeature.where(sub_category_id: sub_cat.map { |cat| cat.id if cat.identifier[/ram/] }.join.to_i)
  end

  def items_to_cart
    eval(params[:ids]).map do |k, v|
      @order_item = current_order.order_items.new
      @order_item.quantity = 1
      @order_item.admin_product_feature_id = v.to_i
      @order_item.save
      end
    redirect_to :back
  end
end
