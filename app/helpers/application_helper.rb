module ApplicationHelper

  def category_buttons
    Admin::Category.all
  end

  def sub_category_buttons
    Admin::SubCategory.all
  end

  def check_user
     if user_signed_in? && current_user.role == 'super_admin'
      '<li><a href="/admin">Admin</a></li>'.html_safe
     end
  end
end
