class Admin::SubCategoriesController < Admin::AdminController
  before_action :set_admin_sub_category, only: [:show, :edit, :update, :destroy]

  def index
    @admin_sub_categories = Admin::SubCategory.all
  end

  def show
  end

  def new
    @admin_sub_category = Admin::SubCategory.new
  end

  def create
    @admin_sub_category = Admin::SubCategory.create(admin_sub_category_params)
    if @admin_sub_category.errors.empty?
      redirect_to admin_sub_categories_path(@admin_sub_category)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @admin_sub_category.update(admin_sub_category_params)
    if @admin_sub_category.errors.empty?
      redirect_to admin_sub_category_path(@admin_sub_category)
    else
      render 'new'
    end
  end

  def destroy
    @admin_sub_category.destroy
   redirect_to action: :index

  end

  private
    def set_admin_sub_category
      @admin_sub_category = Admin::SubCategory.find(params[:id])
    end

    def admin_sub_category_params
      params.require(:admin_sub_category).permit(:category_id, :name, :identifier)
    end
end