class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @categories = Admin::Category.all
  end

  def list
    @order_item = current_order.order_items.new
    @page = params[:page]
    @product_param = params[:product]
    @products_all = Admin::ProductFeature.where(identifier: @product_param)

    product_num = 21
    num_all_productsts = @products_all.count
    @pages = num_all_productsts / product_num
    @products = @products_all

    if @page.nil?
      @products = @products_all
      @order_item = current_order.order_items.new
    else
      @products = @products_all
      @order_item = current_order.order_items.new
    end
  end

  def show
    @order_item = current_order.order_items.new
    unless @products = Admin::ProductFeature.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
