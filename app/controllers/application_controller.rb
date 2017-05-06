class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order
  helper_method :product_all
  helper_method :currency
  helper_method :category


  def currency
    Admin::Currency.all
  end

  def category
    Admin::Category.all
  end

  def product_all
    Admin::ProductFeature.all
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
