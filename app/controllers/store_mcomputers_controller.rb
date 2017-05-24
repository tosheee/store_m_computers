class StoreMcomputersController < ApplicationController

  def store_mcomputers
    @categories = category
    @products = product_all
  end

  def show
    @currency = currency
    @order_item = current_order.order_items.new
    unless @products = product_all.where(id: params[:id]).first
      render text: 'Page not found', status: 404
    end
  end

  def list
    @currency = currency
    @page = params[:page].to_i
    @product_param = params[:product]
    product_num = 9
    @prod_filter_names = convert_to_hash(product_all.where(identifier: params[:product]).first.description)[:properties][:property].map{|d| d[:name]}

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

  def filters_product(products_all)
    product_filters = {}
    properties = products_all.map { |prod| convert_to_hash(prod.description)[:properties][:property]}
    prod_filter_names = product_filter_name(products_all)

    prod_filter_names.map do |name|
      if name[/Manufacturer|Screen size|Screen Resolution|Memory size|CPU Model/]
        product_filters[name] = properties.map do |property|
          property.map { |p| clean_value_filter(name, p[:text].squish) if p.is_a?(Hash) && p[:name] == name  }.join
        end.reject { |c| c.empty? }.uniq.sort
      end
    end

    product_filters
  end

  def clean_value_filter(name, value)
    if name[/Manufacturer/]
      value
    elsif name[/Screen size/]
      value[/\d+.\d|\d+/]
    elsif name[/Screen Resolution/]
      value.gsub(' ', '')[/[0-9]{4}x[0-9]{3,4}/]
    elsif name[/Memory size/]
      value[/\d+\sGB/i].to_s
    elsif name[/CPU Model/]
      value[/(AMD|intel)\s(\w\d|core|atom|celeron|dual-core|pentium)\si\d/i]
    else
      value
    end
  end

  def product_filter_name(products_all)
    convert_to_hash(products_all.first.description)[:properties][:property].map{|d| d[:name]}
  end

  def filter_result(param, products_data)
    filter_param = JSON.parse(param.gsub('(', '[').gsub(')', ']'))

    filtered_products = []

    unless filter_param.map { |k, v| k[/Manufacturer/] }.join.empty?
      filter_param.map do |keys, values|
        products_data.select do |product|
          convert_to_hash(product.description)[:properties][:property].each do |product_val|
            if product_val.is_a?(Hash) &&  product_val[:name][/Manufacturer/i]
              if product_val[:name][/#{keys}/i]
                values.map do |value|
                  removed = /(\(|,).*/i
                  if product_val[:text].gsub(removed, '')[/#{value}/i]
                    #puts product_val[:text].gsub(removed, '')
                    filtered_products << product
                  end
                end
              end
            end
          end
        end
      end
    else
      filter_param.map do |keys, values|
        products_data.select do |product|
          convert_to_hash(product.description)[:properties][:property].each do |product_val|
            if product_val.is_a?(Hash)
              if product_val[:name][/#{keys}/i]
                values.map do |value|
                  removed = /(\(|,).*/i
                  if product_val[:text].gsub(removed, '')[/#{value}/i]
                    puts product_val[:text].gsub(removed, '')
                    filtered_products << product
                  end
                end
              end
            end
          end
        end
      end
    end
    filtered_products
  end

  def search(search_text, all_products)
    q_product = []
    regex = search_text.split.join('|')

    all_products.select do |product|
      if convert_to_hash(product.description)[:code].to_s[/#{regex}/i]
        q_product << product
      end
    end

    if q_product.size > 0
      q_product
    else
      flash[:error] = 'Няма намерени резултати'
      all_products
    end
  end
end
