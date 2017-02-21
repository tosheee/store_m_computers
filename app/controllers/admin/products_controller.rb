class Admin::ProductsController < ApplicationController
  before_action :set_admin_product, only: [:show, :update, :destroy]

  def index
    if params[:product].capitalize
      @category_name = params[:product].capitalize

      @category_id = Admin::Category.where(name_cat: @category_name).first.id

      @products_all = Admin::Product.where(category_id: @category_id)

      unless @admin_products = @products_all.limit(20)
        render text: "Page not found", status: 404
      end
    else
      @admin_products = Admin::Product.all
    end
  end

  def show
  end

  def new
    @admin_product = Admin::Product.new
  end

  def create
    @admin_product = Admin::Product.new(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to @admin_product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @admin_product }
      else
        format.html { render :new }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @admin_product = Admin::Product.find(params[:id])
    @admin_product.description = eval(@admin_product.description).to_json
    @admin_product
  end


  def update

    render text: params[:category].inspect
    #@category = Catergory.find(params[:id])


    #@categories.update_attributes(params[:category])

    #if @category.errors.empty?
     # redirect_to category_path(@category)
    #else
     # render 'edit'
    #end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.json
  def destroy
    @admin_product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Admin::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_product_params
      params.require(:admin_product).permit(:category_id, :description)
    end
end
