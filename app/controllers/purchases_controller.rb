class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!

  def index
    @purchase_delivery = PurchaseDelivery.new
    redirect_to root_path if !@item.purchase.nil? || current_user == @item.user
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:postcode, :delivery_area_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
