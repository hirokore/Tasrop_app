class ApplicationController < ActionController::Base
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sign_in',notice: "ログインしてください。"
    end
  end

  def after_sign_in_path_for(resource)
    current_user
  end

  def role_change!(user,param)
    if param == "user"
      user.user!
      user.save!
    elsif param == "admin"
      user.admin!
      user.save!
    end
  end

  def friend_sort
    users_ids = []
    current_user.follower_ids.each do |id| 
      users_ids << id if current_user.following_ids.include? id
    end
    users_sort = users_ids.map { |id| User.find(id) }
  end  
end