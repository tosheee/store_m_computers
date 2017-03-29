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
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    @extract_xml = Admin::ExtractXml.find(params[:id])
    @extract_xml.destroy
    redirect_to action: 'index'
  end

  def extract_xml_file
    @extract_xml = Admin::ExtractXml.find(params[:id])
    content = File.read("#{Rails.root}/public#{@extract_xml.attachment}")
    xml_hash = Hash.from_xml_custom(content).first

    new_hash = filter_hash(xml_hash)
    #render text: new_hash
    record_products(new_hash)
    redirect_to action: 'index'
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

end
