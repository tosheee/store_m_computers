class StoreMcomputersController < ApplicationController
  def store_mcomputers
    @categories = Admin::Category.all
  end

  def list
    @category_name = params[:product].capitalize
    category_id = Admin::Category.where(name_cat: @category_name).first.id
    #category_id = category_id.id unless category_id.nil?
    @products_all = Admin::Product.where(category_id: category_id)



    product_num = 21
    num_all_productsts = @products_all.count

    @pages = num_all_productsts / product_num

    @page_param = params[:page].to_i if params[:page].to_i > -1

    if @pages > @page_param
      page = params[:page].to_i * product_num
    end

    unless @products = @products_all.limit(product_num).offset(page)
      render text: "Page not found", status: 404
    end
  end

  def show
    unless @products = Admin::Product.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
