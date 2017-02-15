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
    xml_hash.select do |key, _|
      case
      when key['category'][/NOTEBOOK/i]
        notebook = Admin::Notebook.new
        notebook.description = key
        notebook.save
      else
        next
      end
    end
    redirect_to action: 'index'
  end



  private
  def extract_xml_params
    params.require(:admin_extract_xml).permit(:name, :attachment)
  end
end
