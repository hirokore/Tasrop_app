class CustomsController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_custom, only: [ :edit, :update, :destroy ]

  def new
    @custom = Custom.new
    @tasks = Task.where(user_id: current_user.id)
  end

  def create
    @custom = Custom.new(custom_params)
    @custom.user_id = current_user.id
    if @custom.save
      @custom.task_ids.each do |task_id|
        Custom.task_status_create(@custom,task_id)
      end
      redirect_to customs_path, notice: "登録完了"
    else
      @tasks = Task.where(user_id: current_user.id)
      render :new
    end
  end

  def index
    @customs = Custom.where(user_id: current_user.id).includes(:user)
    @tags = Tag.where(user_id: current_user.id).includes(:user)
    @tasks = Task.where(user_id: current_user.id).includes(:user)
  end

  def show
    Custom.daily_create(params[:id]) unless TaskStatus.where(created_at: Time.zone.now.all_day).where(user_id: current_user.id).present?
    @custom = Custom.find_by(user_id: params[:id])
    @customs = Custom.all
  end

  def edit
    @tasks = Task.where(user_id: current_user.id)
  end

  def destroy
    Custom.custom_release(@custom)
    @custom.destroy
    redirect_to customs_path, notice: "削除完了"
  end

  def update
    old_task_ids = @custom.task_ids
    if @custom.update(custom_params)
      @custom.task_ids.each do |task_id|
        unless old_task_ids.include?(task_id)
          Custom.task_status_create(@custom,task_id)
        end
      end
      redirect_to customs_path, notice: "編集完了"
    else
      @tasks = Task.where(user_id: current_user.id)
      render :new
    end
  end


  def task_status
    @status = TaskStatus.find(params[:id])
    @status.task_status = !@status.task_status
    @tag = Task.find(@status.task_id).tags
    if @status.task_status
      @tag.each do |tag|
        tag.total_time += Task.find(@status.task_id).task_time
        tag.save
      end
    else
      @tag.each do |tag|
        tag.total_time -= Task.find(@status.task_id).task_time
        tag.save
      end
    end
    @status.save
  end

  private

  def custom_params
    params.require(:custom).permit(:title, :displayed, :use_comment, :use_picture, :mentor, task_ids: [])
  end

  def set_custom
    @custom = Custom.find(params[:id])
  end

  def task_status_params
    params.require(:task_status).permit(:task_status, :comment, :use_comment, :use_picture, :picture)
  end

end
