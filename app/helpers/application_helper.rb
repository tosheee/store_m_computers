module ApplicationHelper

  def category_buttons
    Admin::Category.all
  end

  def sub_category_buttons
    Admin::SubCategory.all
  end

  def check_user
     if user_signed_in? && current_user.role == 'super_admin'
      '<li><a href="/admin">Admin</a></li>'.html_safe
     end
  end

  def convert_price(price)
    if price[/EUR/i]
       (price.to_f * @currency.select{|v| v.identifier[/EUR/]}.first.rate_equals).round(2)
    elsif price[/USD/i]
      (price.to_f * @currency.select{|v| v.identifier[/USD/]}.first.rate_equals).round(2)
    else
      price.gsub(/BGN/i, '')
    end
  end

  def veiw_convert_hash(convert)
    eval(convert)
  end
end
