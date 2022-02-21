class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id              
  belongs_to :state_id                 
  belongs_to :delivery_charge_burden_id
  belongs_to :delivery_area_id         
  belongs_to :delivery_day_id          

  validates :category_id,              presence: true, numericality: { other_than: 1}
  validates :state_id,                 presence: true, numericality: { other_than: 1}
  validates :delivery_charge_burden_id,presence: true, numericality: { other_than: 1}
  validates :delivery_area_id,         presence: true, numericality: { other_than: 1}
  validates :delivery_day_id,          presence: true, numericality: { other_than: 1}
end
