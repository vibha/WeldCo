module ApplicationHelper
  
  def admin_users
    User.admins
  end
  
end
