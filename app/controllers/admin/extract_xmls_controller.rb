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
      case
      when key[:classname].to_s.squish[/notebook/i]
        product.category_id = 20
        product.sub_category_id = 2
        product.identifier = 'laptops'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/tablet/i]
        product.category_id = 23
        product.sub_category_id = 4
        product.identifier = 'tablets'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Smart Phone/i]
        product.category_id = 23
        product.sub_category_id = 3
        product.identifier = 'smartphones'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/FAN/i]
        product.category_id = 31
        product.sub_category_id = 6
        product.identifier = 'fan'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/CPU/i]
        product.category_id = 31
        product.sub_category_id = 7
        product.identifier = 'cpu'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Mainboard/i]
        product.category_id = 31
        product.sub_category_id = 8
        product.identifier = 'mainboard'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Video Card/i]
        product.category_id = 31
        product.sub_category_id = 9
        product.identifier = 'video_card'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/Case/i]
        product.category_id = 31
        product.sub_category_id = 10
        product.identifier = 'Case'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/HDD/i]
        product.category_id = 31
        product.sub_category_id = 11
        product.identifier = 'hard_disks'
        product.description = key
        product.save
      when key[:classname].to_s.squish[/RAM/i]
      product.category_id = 31
      product.sub_category_id = 12
      product.identifier = 'hard_disks'
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
