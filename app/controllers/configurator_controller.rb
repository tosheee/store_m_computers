# pc configurator
class ConfiguratorController < ApplicationController
  def configurator
    configurator_products = Admin::ConfigurationIdentifier.all
    @currency = currency
    @products_identifiers = configurator_products.first.identifier.squish.split(',').map(&:squish)
    @product_translate = eval(configurator_products.last.identifier)
    @products_identifiers.map do |identifier|
      instance_variable_set("@#{identifier}", find_product(identifier))
    end
  end

  def find_product(product)
    product_all.where(identifier: product)
  end

  def convert_param(params)
    params[/(?<=\{).*(?=\})/].split(',').map do |item|
      "{'id'=>'#{item[/(?<=&id=)\d+(?=&q)/]}','quantity'=>'#{item[/(?<=&q=)\d+/]}'}"
    end
  end

  def show
    offer_prod = params[:offer_products]
    @params_product = offer_prod[/{.*}/]
    products = convert_param(offer_prod)
    @offer_products = []
    sum_p = offer_prod[/(?<=&sum_price=)\d+,\d+/].to_s.gsub(',', '.')
    sum_p.empty? ? @sum_price = '' : @sum_price = sum_p

    products.each do |k|
      k = eval(k)
      @offer_products << [product_all.where(id: k['id']), k['quantity']]
    end

    @offer_products
  end

  def items_to_cart
    products = convert_param(params[:ids])
    products.each do |k|
      k = eval(k)
      @order_item = current_order.order_items.new
      @order_item.quantity = k['quantity'].to_i
      @order_item.admin_product_feature_id = k['id'].to_i
      @order_item.save
    end
    redirect_to :back
  end
end
