class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :product, :price, :image, :category_id, :state_id, :delivery_charge_burden_id,
                                 :delivery_area_id, :delivery_day_id).merge(user_id: current_user.id)
  end
end
