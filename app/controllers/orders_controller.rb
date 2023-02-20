class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]

  def index
  end

  def create
  end

  private

  def move_to_index
    @item = Item.find(params[:id])
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

end
