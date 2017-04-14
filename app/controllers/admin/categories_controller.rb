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
    @admin_category = Admin::Category.create(admin_category_params)
    if @admin_category.errors.empty?
      redirect_to admin_categories_path(@admin_category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @admin_category.update(admin_category_params)
    if @admin_category.errors.empty?
      redirect_to @admin_category
    else
      render :edit
    end
  end

  def destroy
    @admin_category.delete
    redirect_to action: 'index'
  end

  private
    def set_admin_category
      @admin_category = Admin::Category.find(params[:id])
    end

    def admin_category_params
      params.require(:admin_category).permit(:name_cat, :view_cat)
    end
end