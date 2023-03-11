class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show]
before_action :move_to_index

  def show
    @user = User.find(params[:id])
    card_registration
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

  def card_registration
    if current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token) 
      @card = customer.cards.first
    end
  end
end
