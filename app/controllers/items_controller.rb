class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
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
    redirect_to root_path if !@item.purchase.nil? || current_user != @item.user
  end

  def update
    if @item.update(item_params)
      @item.save
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to unless @item.user_id == current_user.id
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:description, :product, :price, :image, :category_id, :state_id, :delivery_charge_burden_id,
                                 :delivery_area_id, :delivery_day_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
