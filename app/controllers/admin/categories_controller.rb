class Admin::CategoriesController < Admin::AdminController
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  def index
    @admin_categories = Admin::Category.all
  end

  def show
  end

  def new
    @admin_category = Admin::Category.new
  end

  def create
    @admin_category = Admin::Category.new(admin_category_params)
    @admin_category.save
    if @admin_category.errors.empty?
      redirect_to 'index'
    else
      render :new
    end
  end

  def edit
  end

  def update
    render text: admin_category_params

    #@admin_category.update(admin_category_params)

    #if @admin_category.errors.empty?
     # redirect_to @admin_category
    #else
     # render :edit
    #end
  end

  def destroy
    @admin_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Admin::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:admin_category).permit(:name_cat, :view_cat)
    end
end
