class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_index, only: [:index]

  def index
  end

  def create
    @order = Order.create(order_params)
    Address.create(address_params)
  end

  private

  def order_params
    params.merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def address_params
    params.permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone).merge(order_id: @order.id)
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end

end
