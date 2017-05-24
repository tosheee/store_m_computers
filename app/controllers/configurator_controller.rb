# pc configurator
class ConfiguratorController < ApplicationController
  def configurator
    @currency = currency
    @fans = find_product('fan')
    @cpus = find_product('cpu')
    @mainboards = find_product('mainboard')
    @video_cards = find_product('video_card')
    @cases = find_product('case')
    @hard_disks = find_product('hard_disks')
    @rams = find_product('ram')
  end

  def find_product(product)
    cat_product = sub_cat.map { |cat| cat.id if cat.identifier[/#{product}/] }
    product_all.where(sub_category_id: cat_product.join.to_i)
  end

  def items_to_cart
    products = convert_to_hash(params[:ids].tr('(', '[').tr(')', ']'))
    products.map do |k,|
      next if k['id'][/undefined/]
      @order_item = current_order.order_items.new
      @order_item.quantity = k['quantity'].to_i
      @order_item.admin_product_feature_id = k['id'].to_i
      @order_item.save
    end
    redirect_to :back
  end
end
