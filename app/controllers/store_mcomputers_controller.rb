class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @currency = Admin::Currency.all
    @categories = Admin::Category.all
    @products_all = Admin::ProductFeature.where(identifier: @product_param)
    @product_filter = @products_all.map { |prod| prod.description }
  end

  def search
    @currency = Admin::Currency.all
    @order_item = current_order.order_items.new
    @page = params[:page]
    @product_param = params[:product]
    @products_all = Admin::ProductFeature.where(identifier: @product_param)

    @product_filter = filter(@products_all)

    product_num = 21
    num_all_productsts = @products_all.count
    @pages = num_all_productsts / product_num



    if params[:search].present?
      regex = params[:search]
      q_product = []
      all_products = Admin::ProductFeature.all

      all_products.select do |product|
        if eval(product.description)[:code].to_s[/#{regex}/i]
          q_product << product
        else
          'no result'
        end
      end
    else
      'no '
    end
    @products = q_product
  end

  def list_old
    @currency = Admin::Currency.all
    @order_item = current_order.order_items.new
    @page = params[:page]
    @product_param = params[:product]
    @products_all = Admin::ProductFeature.where(identifier: @product_param)

    @product_filter = filter(@products_all)

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
    @currency = Admin::Currency.all
    @order_item = current_order.order_items.new
    unless @products = Admin::ProductFeature.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end

  def filter(products_all)
    properties = products_all.map { |prod| eval(prod.description)[:properties][:property]}

    brands = properties.map { |property| property.map { |p| p[:text].gsub(/Hewlett-Packard|HP ZBook Studio G3/, 'HP') if p.is_a?(Hash) && p[:name]== 'Manufacturer' }.join.squish }.uniq
    brands = brands.reject { |c| c.empty? }
    #render text: brand.reject { |c| c.empty? }

    cpu_filter = /Intel (Core|Atom) (i\d+|Pentium|Xeon|M|Atom|Celeron)?/
    cpus = properties.map { |property| property.map { |p| p[:text][cpu_filter] if p.is_a?(Hash) && p[:name]== 'CPU Model' }.join.squish }.uniq
    cpus = cpus.reject { |c| c.empty? }.sort
    # cpu, ram, video, diagonal ,resolution, hard, os
    [brands, cpus]
  end


end
