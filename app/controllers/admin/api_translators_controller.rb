class Admin::ApiTranslatorsController < ApplicationController
  before_action :set_admin_api_translator, only: [:show, :edit, :update, :destroy]

  # GET /admin/api_translators
  # GET /admin/api_translators.json
  def index
    @admin_api_translators = Admin::ApiTranslator.all
  end

  # GET /admin/api_translators/1
  # GET /admin/api_translators/1.json
  def show
  end

  # GET /admin/api_translators/new
  def new
    @admin_api_translator = Admin::ApiTranslator.new
  end

  # GET /admin/api_translators/1/edit
  def edit
  end

  # POST /admin/api_translators
  # POST /admin/api_translators.json
  def create
    @admin_api_translator = Admin::ApiTranslator.new(admin_api_translator_params)

    respond_to do |format|
      if @admin_api_translator.save
        format.html { redirect_to @admin_api_translator, notice: 'Api translator was successfully created.' }
        format.json { render :show, status: :created, location: @admin_api_translator }
      else
        format.html { render :new }
        format.json { render json: @admin_api_translator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/api_translators/1
  # PATCH/PUT /admin/api_translators/1.json
  def update
    respond_to do |format|
      if @admin_api_translator.update(admin_api_translator_params)
        format.html { redirect_to @admin_api_translator, notice: 'Api translator was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_api_translator }
      else
        format.html { render :edit }
        format.json { render json: @admin_api_translator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/api_translators/1
  # DELETE /admin/api_translators/1.json
  def destroy
    @admin_api_translator.destroy
    respond_to do |format|
      format.html { redirect_to admin_api_translators_url, notice: 'Api translator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_api_translator
      @admin_api_translator = Admin::ApiTranslator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_api_translator_params
      params.require(:admin_api_translator).permit(:worlds)
    end
end
