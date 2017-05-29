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

  def show
    @sum_price = params[:sum_price]
    @params_product = params[:ids]
    products = convert_to_hash(@params_product.tr('(', '[').tr(')', ']'))
    @offer_products = []

    products.map do |k,|
      unless k['id'][/undefined/]
        @offer_products << product_all.where(id: k['id'])
      end
     end

    @offer_products
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
