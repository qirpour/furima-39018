class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show]
before_action :move_to_index

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

private

  def move_to_index
    if current_user.id != params[:id].to_i
    redirect_to root_path
    end
  end
end
