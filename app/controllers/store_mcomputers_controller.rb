class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @categories = category
  end


  def filters_product(products_all)
    properties = products_all.map { |prod| eval(prod.description)[:properties][:property]}

      brands = properties.map { |property| property.map { |p| p[:text].gsub(/Hewlett-Packard|HP ZBook Studio G3/, 'HP') if p.is_a?(Hash) && p[:name]== 'Manufacturer' }.join.squish }.uniq
      brands = brands.reject { |c| c.empty? }
      #render text: brand.reject { |c| c.empty? }

      cpu_filter = /Intel (Core|Atom) (i\d+|Pentium|Xeon|M|Atom|Celeron)?/
      cpus = properties.map { |property| property.map { |p| p[:text][cpu_filter] if p.is_a?(Hash) && p[:name]== 'CPU Model' }.join.squish }.uniq
      cpus = cpus.reject { |c| c.empty? }.sort
      # cpu, ram, video, diagonal ,resolution, hard, os
      {'Производител' => brands, 'Процесори'=> cpus}

  end

  def list_test
    items = product_all.where(identifier: 'laptops')
    render text: filters_product(items).map {|k, v| }
  end

  def list
    @currency = currency
    @page = params[:page].to_i
    @product_param = params[:product]
    product_num = 10

    if params[:search].present?
      items = search(params[:search], product_all)
      num_all_products = items.count
    elsif params[:product].present? && params[:filter].present?
      prod_filter = product_all.where(identifier: params[:product])
      items = filter_result(params[:filter], prod_filter)
      num_all_products = items.count
    elsif params[:product].present?
      page_product = product_all.where(identifier: params[:product])
      num_all_products = page_product.count

      if @page.nil?
        items = page_product.limit(product_num)
      else
        items = page_product.limit(product_num).offset(@page)
      end
    else
      redirect_to action: store_mcomputers
    end

    @pages = num_all_products / product_num
    @filters = filters_product(product_all.where(identifier: @product_param)) if @product_param.present?
    @products = items
    @order_item = current_order.order_items.new
  end

  def filter_result(param, products)
    q_product = []
    products.select do |product|
      if eval(product.description)[:code].to_s[/#{param}/i]
        q_product << product
      end
    end

    if q_product.size > 0
      q_product
    else
      flash[:error] = "Няма намерени резултати"
      products
    end
  end

  def search(search_text, all_products)
    q_product = []
    regex = search_text.split.join('|')

    all_products.select do |product|
      if eval(product.description)[:code].to_s[/#{regex}/i]
        q_product << product
      end
    end

    if q_product.size > 0
      q_product
    else
      flash[:error] = "Няма намерени резултати"
      all_products
    end
  end

  def show
    @currency = currency # method app controller
    @order_item = current_order.order_items.new
    unless @products = Admin::ProductFeature.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
