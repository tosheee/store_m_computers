class StoreMcomputersController < ApplicationController
  def store_mcomputers
    @categories = Admin::Category.all
  end

  def list
    @category_name = params[:product].capitalize
    category_id = Admin::Category.where(name_cat: @category_name).first.id
    #category_id = category_id.id unless category_id.nil?
    @products_all = Admin::Product.where(category_id: category_id)

    unless @products = @products_all.limit(20)
      render text: "Page not found", status: 404
    end
  end

  def show
    unless @products = Admin::Product.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
