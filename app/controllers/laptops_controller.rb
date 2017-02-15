class LaptopsController < ApplicationController

  def index
    @laptops = Admin::Notebook.all.limit(9)
  end

  def show
    unless @laptop = Admin::Notebook.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end
end
