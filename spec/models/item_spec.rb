require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品' do
    context '出品できる場合' do
      it '必要な項目が全て埋まっていれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it 'productが空だと出品できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end
      it 'descriptionが空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'state_idに「---」が選択されている場合は出品できない' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank")
      end
      it 'delivery_charge_burden_idに「---」が選択されている場合は出品できない' do
        @item.delivery_charge_burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge burden can't be blank")
      end
      it 'delivery_area_idに「---」が選択されている場合は出品できない' do
        @item.delivery_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery area can't be blank")
      end
      it 'delivery_day_idに「---」が選択されている場合は出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '価格が¥300以下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が¥9999999より大きい場合は出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が全角の場合は登録できない' do
        @item.price = '１１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
