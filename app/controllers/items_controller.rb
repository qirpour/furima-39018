class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.include(:user)
  end

  def create
  end

  private

  
end
