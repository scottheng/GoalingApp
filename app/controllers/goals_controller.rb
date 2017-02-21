class GoalsController < ApplicationController
  before_action :require_signed_in!

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(id: params[:id])
    render :show
  end

  def edit
    @goal = Goal.find(id: params[:id])
    render :edit
  end

  def update
    @goal = current_user.goals.find(params[:id])

    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.goals.find(params[:id]).destroy
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :is_public)
  end
end
