class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :delivery_area_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'は半角数字3桁-(ハイフン)半角数字4桁で入力して下さい' }
    validates :city
    validates :block
    validates :building
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は半角数字10桁もしくは半角数字11桁(ハイフンなし)で入力して下さい' }
    validates :token
  end
  validates :delivery_area_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, delivery_area_id: delivery_area_id, city: city, block: block, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end