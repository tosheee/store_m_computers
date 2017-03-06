module StoreMcomputersHelper

  def nav_meny

  end

  def property_products(description)
    description[:properties][:property].each do |property|
    '<li>' + property[:name]+': ' + property[:text] +'</li>'
    end
  end

end