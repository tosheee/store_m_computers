class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @categories = Admin::Category.all
  end

  def list
    @page = params[:page]
    @product_param = params[:product]
    @products_all = Admin::ProductFeature.where(identifier: @product_param)

    product_num = 21
    num_all_productsts = @products_all.count
    @pages = num_all_productsts / product_num
    @products = @products_all

    if @page.nil?
      @products = @products_all.limit(product_num).offset(0)
    else
      @products = @products_all.limit(product_num).offset(@page)
    end
  end

  def show
    unless @products = Admin::ProductFeature.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
