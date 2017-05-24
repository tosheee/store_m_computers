module StoreMcomputersHelper

  def property_products(description)
    description[:properties][:property].each do |property|
    '<li>' + property[:name]+': ' + property[:text] +'</li>'
    end
  end

end