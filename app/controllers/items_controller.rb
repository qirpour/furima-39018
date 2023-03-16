class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :move_to_index_sold_out, only: [:edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def search
    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  private

  def item_params
    params.require(:item).permit(:title, :explanation, :price, :category_id, :condition_id, :delivery_charge_id,
                                 :prefecture_id, :delivery_day_id, {images: []}).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    return if current_user.id == @item.user.id

    redirect_to root_path
  end

  def move_to_index_sold_out
    @item = Item.find(params[:id])
    return unless @item.order

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
