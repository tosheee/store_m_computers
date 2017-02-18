class Admin::ExtractXmlsController < ApplicationController
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
    xml_hash = Hash.from_xml content
    record_products(xml_hash['data']['productlist']['product'])
  end

  def record_products(xml_hash)
    @buffer = []
    xml_hash.select do |key, _|
      unless key['classname'].nil?
        product = Admin::Product.new
        case
        when key['classname'][/notebook/i]
          product.category_id = 1
          product.description = key
          product.save
        when key['classname'][/tablet/i]
          product.category_id = 2
          product.description = key
          product.save
        when key['classname'][/Smart Phone/i]
          product.category_id = 3
          product.description = key
          product.save
        else
          @buffer << key
        end
      end
    end
    @buffer
    redirect_to action: 'index'
  end

  private
  def extract_xml_params
    params.require(:admin_extract_xml).permit(:name, :attachment)
  end
end
