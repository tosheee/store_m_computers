class OrderItem < ActiveRecord::Base
  belongs_to :admin_product_feature, :class_name => 'Admin::ProductFeature'
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :admin_product_feature_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      price = eval(admin_product_feature.description)[:price]
      currency = eval(admin_product_feature.description)[:currency]
      convert_price([price, currency].join)
    end
  end

  def convert_price(price)

    if price[/EUR/i]
      (price.to_f * @currency.select { |v| v.identifier[/EUR/] }.first.rate_equals).round(2)
    elsif price[/USD/i]
      (price.to_f * @currency.select { |v| v.identifier[/USD/] }.first.rate_equals).round(2)
    else
      price.gsub(/BGN/i, '')
    end
  end

  def total_price
    unit_price * quantity
  end

  private
  def admin_product_feature_present
    if admin_product_feature.nil?
      errors.add(:admin_product_feature, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end

end
