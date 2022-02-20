class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :product,                   null: false
      t.text       :description,               null: false
      t.integer    :category_id,               null: false
      t.integer    :state_id,                  null: false
      t.integer    :delivery_charge_burden_id, null: false
      t.integer    :delivery_area_id,          null: false
      t.integer    :delivery_day_id,           null: false
      t.integer    :price,                     null: false
      t.references :user,                      null: false
      t.timestamps
    end
  end
end