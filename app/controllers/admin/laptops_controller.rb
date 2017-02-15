class Admin::LaptopsController < Admin::AdminController
  before_action :set_admin_laptop, only: [:show, :edit, :update, :destroy]

  # GET /admin/laptops
  # GET /admin/laptops.json
  def index
    @admin_laptops = Admin::Laptop.all
  end

  # GET /admin/laptops/1
  # GET /admin/laptops/1.json
  def show
  end

  # GET /admin/laptops/new
  def new
    @admin_laptop = Admin::Laptop.new
  end

  # GET /admin/laptops/1/edit
  def edit
  end

  # POST /admin/laptops
  # POST /admin/laptops.json
  def create
    @admin_laptop = Admin::Laptop.new(admin_laptop_params)

    respond_to do |format|
      if @admin_laptop.save
        format.html { redirect_to @admin_laptop, notice: 'Laptop was successfully created.' }
        format.json { render :show, status: :created, location: @admin_laptop }
      else
        format.html { render :new }
        format.json { render json: @admin_laptop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/laptops/1
  # PATCH/PUT /admin/laptops/1.json
  def update
    respond_to do |format|
      if @admin_laptop.update(admin_laptop_params)
        format.html { redirect_to @admin_laptop, notice: 'Laptop was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_laptop }
      else
        format.html { render :edit }
        format.json { render json: @admin_laptop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/laptops/1
  # DELETE /admin/laptops/1.json
  def destroy
    @admin_laptop.destroy
    respond_to do |format|
      format.html { redirect_to admin_laptops_url, notice: 'Laptop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_laptop
      @admin_laptop = Admin::Laptop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_laptop_params
      params.require(:admin_laptop).permit(:category_id, :code, :name, :product_status, :hashpromo, :general_description, :classname, :price, :currency, :main_picture_url, :manufacturer, :category, :partnum, :gallery, :vendor_url, :property_Manufacturer, :property_Mnfr_Part, :property_Model, :property_Screen_size, :property_Screen_type, :property_Screen_Resolution, :property_Memory_size, :property_Memory_type, :property_CPU, :Model, :property_Graphics, :property_HDD, :property_SSD, :property_Disk_Specifications, :property_Interface, :property_Camera, :property_ODD, :property_OS, :property_Wi-Fi, :property_Audio, :property_LAN, :property_Bluetooth, :property_Body_Color, :property_Battery, :property_Dimensions, :property_Weight, :property_Other, :property_Warranty)
    end
end
