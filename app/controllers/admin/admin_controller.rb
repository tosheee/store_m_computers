class Admin::AdminController < ApplicationController

  before_filter :ensure_admin_user!

  def ensure_admin_user!
    unless user_signed_in? && current_user.role == "super_admin"
      redirect_to root_path
    end
  end

  def admin

  end

end
