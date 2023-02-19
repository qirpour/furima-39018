class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to root_path
    else
    render :new
    end
  end

def show
  @item = Item.find(params[:id])
end

  private

  def item_params
    params.require(:item).permit(:title, :image, :explanation, :price, :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :delivery_day_id).merge(user_id: current_user.id)

  end

end
