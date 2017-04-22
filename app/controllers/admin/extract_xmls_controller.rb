class Admin::ExtractXmlsController < Admin::AdminController

  def index
    @extract_xmls = Admin::ExtractXml.all
  end

  def new
    @extract_xml = Admin::ExtractXml.new
  end

  def create
    @extract_xml = Admin::ExtractXml.new(extract_xml_params)
    if @extract_xml.save
      flash[:notice] = "XML file is ready!"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    @extract_xml = Admin::ExtractXml.find(params[:id])
    @extract_xml.destroy
    flash[:notice] = "XML file is ready!"
    redirect_to action: 'index'
  end

  def delete_all_products
    Admin::ProductFeature.delete_all
    flash[:notice] = "Database items deleted"
    redirect_to action: 'index'
  end

  def update_products
    new_hash = extract_helper_xml_file
    all_products = Admin::ProductFeature.all

    check_and_change_prices(new_hash,  all_products)
    product_ids = all_products.map { |old_product|  eval(old_product.description)[:id] }
    xml_product_ids = new_hash.map { |new_product|  new_product[:id] }
    new_products = xml_product_ids - product_ids
    products_for_deleted = product_ids - xml_product_ids

    record_new_products(new_hash, product_ids) if new_products.any?
    delete_old_products(products_for_deleted, all_products) if products_for_deleted.any?

     flash[:notice] = "Database updated successfully!   | New products: #{@new_products_counter} | Delete products: #{products_for_deleted.size.to_i} | Price: #{@price_counter} |"
     redirect_to action: 'index'
  end


  def delete_old_products(products_for_deleted, all_products)
    products_for_deleted.select do |id|
      product = all_products.select { |product| eval(product.description)[:id] == id }
      old_product =  Admin::ProductFeature.find(product.first.id)
      old_product.delete
    end
  end


  def record_new_products(new_hash, product_ids)
    products_for_record = []
    @new_products_counter = 0
    new_hash.select do |xml_product|
      if !product_ids.include?(xml_product[:id])
        @new_products_counter += 1
        products_for_record << xml_product
      end
    end
    record_products(products_for_record)
  end

  def check_and_change_prices(new_hash, all_products)
    new_product_ids = new_hash.map {|xml_product| xml_product[:id]}
    new_product_prices = new_hash.map {|xml_product| xml_product[:price]}

    new_product_data = new_product_ids.zip(new_product_prices)

    old_product_ids = all_products.map { |product| eval(product.description)[:id] }
    old_product_prices = all_products.map { |product| eval(product.description)[:price] }

    old_product_data = old_product_ids.zip(old_product_prices)

    product_different_price = []

    new_product_data.select do |n_id, n_price|
      old_product_data.select do |o_id, o_price|
        if n_id == o_id && n_price != o_price
          product_different_price <<  [n_id, n_price]
        end
      end
    end
    @price_counter = 0
    product_different_price.select do |id, price|
      product = all_products.select { |product| eval(product.description)[:id] == id }
      old_product =  Admin::ProductFeature.find(product.first.id)
      old_product.description = product.first.description.gsub(/(?<=price=>\").*?(?=\")/, "#{price}")
      @price_counter += 1
      old_product.save
    end
  end

  def extract_xml_file
    new_hash = extract_helper_xml_file
    record_products(new_hash)
    flash[:notice] = "XML file is ready!"
    redirect_to action: 'index'
  end

  def extract_helper_xml_file
    @extract_xml = Admin::ExtractXml.find(params[:id])
    content = File.read("#{Rails.root}/public#{@extract_xml.attachment}")
    xml_hash = from_xml_custom(content).first
    filter_hash(xml_hash)
  end

  def filter_hash(xml_hash)
    hashes = xml_hash.last[:productlist][:product]
    new_hashes = hashes.map do |hash|
      hash.select do |key, value|
        key.to_s[/^id$|code|product_status|general_description|classname$|price|currency|main_picture_url|gallery|properties/]
      end
    end
    clean_hash(new_hashes)
  end

  def clean_hash(new_hashes)
    new_hashes.each do |element|
      element.select do |key, val|
        if val.is_a?(Hash)
          val.select do |key1, val1|
            if val1.is_a?(Hash)
              val[:picture].nil? ? '' : val[:picture].delete(:thumbnail_url)
            elsif val1.is_a?(Array)
              val1.map do |val_arr|
                val_arr.delete(:thumbnail_url)
                val_arr.delete(:order)
              end
            end
          end
        else
          key
        end
      end
    end
  end

  def record_products(new_hash)
    new_hash.select do |key|

      product = Admin::ProductFeature.new
      sub_category = Admin::SubCategory.all

      case
      when key[:classname].to_s.squish[/notebook/i]
        laptop_data = sub_category.select {|cat| cat.identifier[/laptop/] }.first
        product.category_id = laptop_data[:category_id]
        product.sub_category_id = laptop_data[:id]
        product.identifier = 'laptops'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/tablet/i]
        tablets_data = sub_category.select {|cat| cat.identifier[/tablets/] }.first
        product.category_id = tablets_data[:category_id]
        product.sub_category_id = tablets_data[:id]
        product.identifier = 'tablets'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Smart Phone/i]
        smartphones_data = sub_category.select {|cat| cat.id if cat.identifier[/smartphones/] }.first
        product.category_id = smartphones_data[:category_id]
        product.sub_category_id = smartphones_data[:id]
        product.identifier = 'smartphones'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/FAN/i]
        fan_data = sub_category.select {|cat| cat.identifier[/fan/] }.first
        product.category_id = fan_data[:category_id]
        product.sub_category_id = fan_data[:id]
        product.identifier = 'fan'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/CPU/i]
        cpu_data = sub_category.select { |cat| cat.identifier[/cpu/] }.first
        product.category_id = cpu_data[:category_id]
        product.sub_category_id = cpu_data[:id]
        product.identifier = 'cpu'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Mainboard/i]
        mainboard_data = sub_category.select { |cat| cat.identifier[/mainboard/] }.first
        product.category_id = mainboard_data[:category_id]
        product.sub_category_id = mainboard_data[:id]
        product.identifier = 'mainboard'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Video Card/i]
        video_card_data = sub_category.select { |cat| cat.identifier[/video_card/] }.first
        product.category_id = video_card_data[:category_id]
        product.sub_category_id = video_card_data[:id]
        product.identifier = 'video_card'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Case/i]
        case_data = sub_category.select { |cat| cat.identifier[/case/] }.first
        product.category_id = case_data[:category_id]
        product.sub_category_id = case_data[:id]
        product.identifier = 'case'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/HDD/i]
        hard_disks_data = sub_category.select { |cat| cat.identifier[/hard_disks/] }.first
        product.category_id = hard_disks_data[:category_id]
        product.sub_category_id = hard_disks_data[:id]
        product.identifier = 'hard_disks'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/RAM/i]
        ram_data = sub_category.select { |cat| cat.identifier[/ram/] }.first
        product.category_id = ram_data[:category_id]
        product.sub_category_id = ram_data[:id]
        product.identifier = 'ram'
        product.description = key
        product.save
      end
    end
  end

  private
  def extract_xml_params
    params.require(:admin_extract_xml).permit(:name, :attachment)
  end

  def from_xml_custom(xml_io)
    begin
      result = Nokogiri::XML(xml_io)
      return { result.root.name.to_sym => xml_node_to_hash(result.root)}
    rescue Exception => e
      # raise your custom exception here
    end
  end

  def xml_node_to_hash(node)
    # If we are at the root of the document, start the hash
    if node.element?
      result_hash = {}
      if node.attributes != {}
        attributes = {}
        node.attributes.keys.each do |key|
          attributes[node.attributes[key].name.to_sym] = node.attributes[key].value
        end
      end
      if node.children.size > 0
        node.children.each do |child|
          result = xml_node_to_hash(child)

          if child.name == "text"
            unless child.next_sibling || child.previous_sibling
              return result unless attributes
              result_hash[child.name.to_sym] = result
            end
          elsif result_hash[child.name.to_sym]

            if result_hash[child.name.to_sym].is_a?(Array)
              result_hash[child.name.to_sym] << result
            else
              result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]] << result
            end
          else
            result_hash[child.name.to_sym] = result
          end
        end
        if attributes
          #add code to remove non-data attributes e.g. xml schema, namespace here
          #if there is a collision then node content supersets attributes
          result_hash = attributes.merge(result_hash)
        end
        return result_hash
      else
        return attributes
      end
    else
      return node.content.to_s
    end
  end
end
