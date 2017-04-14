class Admin::ProductFeaturesController < Admin::AdminController
  before_action :set_admin_product_feature, only: [:show, :edit, :update, :destroy]

  def index
    @page = params[:page]
    @product_param = params[:product]
    @products_all = Admin::ProductFeature.where(identifier: @product_param)

    product_num = 21
    num_all_productsts = @products_all.count
    @pages = num_all_productsts / product_num
    @products = @products_all

    if !@page.nil? && !@product_param.nil?
      @admin_product_features = @products_all.limit(product_num).offset(@page.to_i < 0 || @page.to_i > @pages ? 0 : @page)
    elsif !@product_param.nil?
      @admin_product_features = @products_all.limit(product_num).offset(0)
    else
      @admin_product_features = Admin::ProductFeature.all
    end
  end

  def show
  end

  def new
    @admin_product_feature = Admin::ProductFeature.new
  end

  def create
    @admin_product_feature = Admin::ProductFeature.create(admin_product_feature_params)
    if @admin_product_feature.errors.empty?
        redirect_to admin_product_feature_patch(@admin_product_feature)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
   @admin_product_feature.update(admin_product_feature_params)
    if @admin_product_feature.errors.empty?
      redirect_to action: 'index'
    else
      render :edit
    end
  end

  def destroy
    @admin_product_feature.destroy
    redirect_to admin_product_feature_path(@admin_product_feature)
  end

  private
  def set_admin_product_feature
    @admin_product_feature = Admin::ProductFeature.find(params[:id])
  end

  def admin_product_feature_params
    params.require(:admin_product_feature).permit(:category_id, :sub_category_id, :identifier).tap do |whitelisted|
      whitelisted[:description] = Hash params[:admin_product][:description].deep_symbolize_keys
    end
  end
end
