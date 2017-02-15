class Admin::NotebooksController < ApplicationController
  before_action :set_admin_notebook, only: [:show, :edit, :update, :destroy]

  # GET /admin/notebooks
  # GET /admin/notebooks.json
  def index
    @admin_notebooks = Admin::Notebook.all
  end

  # GET /admin/notebooks/1
  # GET /admin/notebooks/1.json
  def show
  end

  # GET /admin/notebooks/new
  def new
    @admin_notebook = Admin::Notebook.new
  end

  # GET /admin/notebooks/1/edit
  def edit
  end

  # POST /admin/notebooks
  # POST /admin/notebooks.json
  def create
    @admin_notebook = Admin::Notebook.new(admin_notebook_params)

    respond_to do |format|
      if @admin_notebook.save
        format.html { redirect_to @admin_notebook, notice: 'Notebook was successfully created.' }
        format.json { render :show, status: :created, location: @admin_notebook }
      else
        format.html { render :new }
        format.json { render json: @admin_notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/notebooks/1
  # PATCH/PUT /admin/notebooks/1.json
  def update
    respond_to do |format|
      if @admin_notebook.update(admin_notebook_params)
        format.html { redirect_to @admin_notebook, notice: 'Notebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_notebook }
      else
        format.html { render :edit }
        format.json { render json: @admin_notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/notebooks/1
  # DELETE /admin/notebooks/1.json
  def destroy
    @admin_notebook.destroy
    respond_to do |format|
      format.html { redirect_to admin_notebooks_url, notice: 'Notebook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_notebook
      @admin_notebook = Admin::Notebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_notebook_params
      params.require(:admin_notebook).permit(:category_id, :description)
    end
end
