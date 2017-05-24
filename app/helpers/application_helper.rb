module ApplicationHelper

  def category_buttons
    Admin::Category.all
  end

  def sub_category_buttons
    Admin::SubCategory.all
  end

  def currency
    Admin::Currency.all
  end

  def check_user
     if user_signed_in? && current_user.role == 'super_admin'
      '<li><a href="/admin">Admin</a></li>'.html_safe
     end
  end

  def convert_price(price)
    result_price = 0.00
    if price[/EUR/i]
      result_price = price.to_f * select_currency('EUR')
    elsif price[/USD/i]
      result_price = price.to_f * select_currency('USD')
    else
      result_price = price
    end
    result_price.to_f.round(2)
  end

  def select_currency(curr)
    currency.where(identifier: curr).first.rate_equals.to_f
  end

  def veiw_convert_hash(convert)
    eval(convert)
  end
end
