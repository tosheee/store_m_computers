class Admin::ProductsController < Admin::AdminController
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:product].capitalize
      @category_name = params[:product].capitalize
      @category_id = Admin::Category.where(name_cat: @category_name).first.id
      @products_all = Admin::Product.where(category_id: @category_id)
      unless @admin_products = @products_all
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
    #render text: params[:admin_product][:description].inspect
    @admin_product.description = params[:admin_product][:description]
    @admin_product.category_id = params[:admin_product][:category_id]
    #render text: @admin_product

    @admin_product.save

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


  def create_custom
    render text: @admin_product

    #@admin_product = Admin::Product.new(admin_product_params)

    #if @admin_product.errors.empty?
     # redirect_to admin_product_path(@admin_product)
    #else
     # render "new"
    #end
  end

  def edit
  end


  def update
    #render text: admin_product_params
    @admin_product.update(admin_product_params)
    if @admin_product.errors.empty?
      redirect_to admin_product_path(@admin_product)
    else
      render :edit
    end
  end

  def destroy
    @admin_product.destroy
  end

  private

    def set_admin_product
      @admin_product = Admin::Product.find(params[:id])
    end

    def admin_product_params
      params.require(:admin_product).permit(:category_id).tap do |whitelisted|
        whitelisted[:description] = Hash params[:admin_product][:description].deep_symbolize_keys
      end
    end
end
