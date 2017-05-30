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

  def select_currency(curr)
    currency_value = Admin::Currency.where(identifier: curr).first.rate_equals
    currency_value.to_f
  end

  def convert_price(price)
    if price[/EUR/i]
    con_price =  price.to_f * select_currency('EUR') * 1.2
    elsif price[/USD/i]
      con_price =  price.to_f * select_currency('USD') * 1.2
    else
      con_price = price.to_f * 1.2
    end
    con_price.round(2)
  end

  def translate_name
    eval(Admin::ApiTranslator.first.worlds)
  end

  def veiw_convert_hash(convert)
    eval(convert)
  end

  def price_dds(price)
    (price.to_f * 1.2).round(2)
  end
end
