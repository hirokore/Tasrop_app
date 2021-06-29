class UsersController < ApplicationController
  before_action :set_user, only: %i[ show follow followed destroy edit]
  before_action :move_to_signed_in
  before_action :set_q, only: [:index, :result, :find]

  def find
  end

  def result
    @results = @q.result
  end

  def index
    @users = User.all.page(params[:page]).per(5)
    @friends = Kaminari.paginate_array(friend_sort).page(params[:page]).per(5)
  end

  def edit
    role_change!(@user,params[:role])
    redirect_to users_path, notice: "権限変更完了"
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "削除完了"
  end

  def show
    @tags = Tag.where(user_id: (params[:id]))
  end

  def follow
    @user = Kaminari.paginate_array(@user.following).page(params[:page]).per(10)
  end
  
  def followed
    @user = Kaminari.paginate_array(@user.followers).page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # 通知機能実装の布石
    params.require(:user).permit(:email, :role, :image, :name, :name_tag, :last_target, :notice, :notice_time)
  end
  
  def set_q
    @q = User.ransack(params[:q])
  end
  
end