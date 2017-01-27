class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.all
  end

  def show
  end

  def rankings
    @users = User.all.sort_by { |user| user.solutions.count }.reverse
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
