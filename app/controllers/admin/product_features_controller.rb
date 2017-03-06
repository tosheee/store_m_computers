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

  # unless params[:id].nil?
  #  @admin_product_features = Admin::ProductFeature.where(sub_category_id: params[:id])
  #else
  # @admin_product_features = Admin::ProductFeature.all
  #end

  def show
  end

  def new
    @admin_product_feature = Admin::ProductFeature.new
  end

  def edit
  end

  def create
    #@admin_product_feature = Admin::ProductFeature.new(admin_product_feature_params)
    #render text: @admin_product
    #@admin_product = Admin::Product.new(admin_product_params)
    #render text: params[:admin_product][:description].inspect
    @admin_product_feature.category_id = params[:admin_product][:category_id]
    @admin_product_feature.category_id = params[:admin_product][:sub_category_id]
    @admin_product_feature.description = params[:admin_product][:description]

    @admin_product_feature.save
    respond_to do |format|
      if @admin_product_feature.save
        format.html { redirect_to @admin_product_feature, notice: 'Product feature was successfully created.' }
        format.json { render :show, status: :created, location: @admin_product_feature }
      else
        format.html { render :new }
        format.json { render json: @admin_product_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #render text: admin_product_params
    @admin_product_feature.update(admin_product_params)
    if @admin_product_feature.errors.empty?
      redirect_to admin_product_feature_path(@admin_product_feature)
    else
      render :edit
    end
  end

  def destroy
    @admin_product_feature.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_features_url, notice: 'Product feature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product_feature
      @admin_product_feature = Admin::ProductFeature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_product_feature_params
      #params.require(:admin_product_feature).permit(:category_id, :sub_category_id, :description)
      params.require(:admin_product_feature).permit(:category_id, :sub_category_id).tap do |whitelisted|
        whitelisted[:description] = Hash params[:admin_product][:description].deep_symbolize_keys
      end
    end
end
