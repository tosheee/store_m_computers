class Admin::ConfigurationIdentifiersController < ApplicationController
  before_action :set_admin_configuration_identifier, only: [:show, :edit, :update, :destroy]

  # GET /admin/configuration_identifiers
  # GET /admin/configuration_identifiers.json
  def index
    @admin_configuration_identifiers = Admin::ConfigurationIdentifier.all
  end

  # GET /admin/configuration_identifiers/1
  # GET /admin/configuration_identifiers/1.json
  def show
  end

  # GET /admin/configuration_identifiers/new
  def new
    @admin_configuration_identifier = Admin::ConfigurationIdentifier.new
  end

  # GET /admin/configuration_identifiers/1/edit
  def edit
  end

  # POST /admin/configuration_identifiers
  # POST /admin/configuration_identifiers.json
  def create
    @admin_configuration_identifier = Admin::ConfigurationIdentifier.new(admin_configuration_identifier_params)

    respond_to do |format|
      if @admin_configuration_identifier.save
        format.html { redirect_to @admin_configuration_identifier, notice: 'Configuration identifier was successfully created.' }
        format.json { render :show, status: :created, location: @admin_configuration_identifier }
      else
        format.html { render :new }
        format.json { render json: @admin_configuration_identifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/configuration_identifiers/1
  # PATCH/PUT /admin/configuration_identifiers/1.json
  def update
    respond_to do |format|
      if @admin_configuration_identifier.update(admin_configuration_identifier_params)
        format.html { redirect_to @admin_configuration_identifier, notice: 'Configuration identifier was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_configuration_identifier }
      else
        format.html { render :edit }
        format.json { render json: @admin_configuration_identifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/configuration_identifiers/1
  # DELETE /admin/configuration_identifiers/1.json
  def destroy
    @admin_configuration_identifier.destroy
    respond_to do |format|
      format.html { redirect_to admin_configuration_identifiers_url, notice: 'Configuration identifier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_configuration_identifier
      @admin_configuration_identifier = Admin::ConfigurationIdentifier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_configuration_identifier_params
      params.require(:admin_configuration_identifier).permit(:identifier)
    end
end
