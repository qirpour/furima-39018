class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item
  before_action :move_to_index, only: [:index]
  before_action :move_to_index_sold_out, only: [:index]

  def index
    if !current_user.card.present?
      redirect_to user_path(current_user.id), notice: '商品購入前にクレジットカードを登録して下さい'
    end
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def move_to_index
    return unless current_user.id == @item.user.id

    redirect_to root_path
  end

  def move_to_index_sold_out
    return if @item.order.nil?
    redirect_to root_path
  end

=begin
  def card_registration
    if current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token) 
      @card = customer.cards.first
    end
  end
=end

  def pay_item
    price = @item.price
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: price,
      customer: customer_token,
      currency: 'jpy'
    )
  end
end
