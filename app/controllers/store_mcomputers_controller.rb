class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @categories = category
  end

  def list
    render text: params[:search]
  end

  def old_list
    @currency = currency # method app controller
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
    @currency = currency # method app controller
    @order_item = current_order.order_items.new
    unless @products = Admin::ProductFeature.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end

  def filter(products_all)
    properties = products_all.map { |prod| eval(prod.description)[:properties][:property]}

    brands = properties.map { |property| property.map { |p| p[:text].gsub(/Hewlett-Packard|HP ZBook Studio G3/, 'HP') if p.is_a?(Hash) && p[:name]== 'Manufacturer' }.join.squish }.uniq
    brands = brands.reject { |c| c.empty? }

    cpu_filter = /Intel (Core|Atom) (i\d+|Pentium|Xeon|M|Atom|Celeron)?/
    cpus = properties.map { |property| property.map { |p| p[:text][cpu_filter] if p.is_a?(Hash) && p[:name]== 'CPU Model' }.join.squish }.uniq
    cpus = cpus.reject { |c| c.empty? }.sort

    # cpu, ram, video, diagonal ,resolution, hard, os
    [brands, cpus]
  end

end
