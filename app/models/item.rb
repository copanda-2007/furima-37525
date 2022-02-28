class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one    :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_charge_burden
  belongs_to :delivery_area
  belongs_to :delivery_day

  validates :description,               presence: true
  validates :product,                   presence: true
  validates :price,                     presence: true,
                                        numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, presence: { message: "can't be blank" }
  validates :category_id,               numericality: { other_than: 1, message: "can't be blank" }
  validates :state_id,                  numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_burden_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_area_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_day_id,           numericality: { other_than: 1, message: "can't be blank" }
  validates :image,                     presence: true
end
