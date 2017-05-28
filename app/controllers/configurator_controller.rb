# pc configurator
class ConfiguratorController < ApplicationController
  def configurator
    @currency = currency
    @products_identifiers = ['cpu', 'fan', 'mainboard', 'ram', 'hdd', 'monitor', 'video_card', 'odd_internal', 'case', 'power_supply', 'keyboard', 'mouse', 'sound_card_internal', 'software', 'lan_card']
    @products_identifiers.map do |identifier|
      instance_variable_set("@#{identifier}", find_product(identifier))
    end
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
