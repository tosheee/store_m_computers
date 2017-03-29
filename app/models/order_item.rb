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
      (eval(admin_product_feature.description)[:price]).to_f
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
