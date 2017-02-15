module ApplicationHelper

  def category_buttons
    @buttons = Admin::Category.all
  end

  def check_user
     if user_signed_in? && current_user.role == 'super_admin'
      '<li><a href="/admin">Admin</a></li>'.html_safe
     end
  end
end
