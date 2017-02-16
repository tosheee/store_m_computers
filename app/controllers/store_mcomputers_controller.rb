class StoreMcomputersController < ApplicationController
  def store_mcomputers
    @categories = Admin::Category.all
  end

  def list
    @category_name = params[:product].capitalize
    category_id = Admin::Category.where(name_cat: @category_name).first
    category_id = category_id.id unless category_id.nil?

    unless @products = Admin::Product.where(id: category_id)
      render text: "Page not found", status: 404
    end
  end

  def show
    unless @products = Admin::Product.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
