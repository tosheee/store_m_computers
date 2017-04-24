class Admin::CurrenciesController < ApplicationController
  before_action :set_admin_currency, only: [:show, :edit, :update, :destroy]

  def index
    @admin_currencies = Admin::Currency.all
  end

  def show
  end

  def new
    @admin_currency = Admin::Currency.new
  end

  def edit
  end

  def create
    @admin_currency = Admin::Currency.create(admin_currency_params)
    if @admin_currency.errors.empty?
      redirect_to action: :index
    else
      render :new
    end
  end

  def update
    @admin_currency.update(admin_currency_params)
    if @admin_currency.errors.empty?
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def destroy
    @admin_currency.destroy
    redirect_to action: :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_currency
      @admin_currency = Admin::Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_currency_params
      params.require(:admin_currency).permit(:name, :identifier, :rate_equals)
    end
end
