class CartsController < ApplicationController
  def show
    @sale = Admin::Sale.new
    @order_items = current_order.order_items
  end

  def sale
    @sale_id = params[:sale_id]
    @sale = Admin::Sale.new
  end
end

