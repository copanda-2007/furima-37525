require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_delivery = FactoryBot.build(:purchase_delivery, user_id: user.id, item_id: item.id)
    sleep 0.2 # 処理が先に読み込まれることが無いように、0.2秒ごとにテスト処理を行う
  end

  describe '商品購入' do
    context '購入できるとき' do
      it '全項目が存在すれば購入できる' do
        expect(@purchase_delivery).to be_valid
      end
      it '建物名がなくても購入できる' do
        @purchase_delivery.building = ''
        expect(@purchase_delivery).to be_valid
      end
    end
    context '購入できないとき' do
      it 'トークンが空では購入できない' do
        @purchase_delivery.token = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では購入できない' do
        @purchase_delivery.postcode = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号が全角では購入できない' do
        @purchase_delivery.postcode = '１２３ー４５６７'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号がハイフンを含まないと購入できない' do
        @purchase_delivery.postcode = '1234567'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号がの桁数が間違っていると購入できない' do
        @purchase_delivery.postcode = '1234-567'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が選択されていないと購入できない' do
        @purchase_delivery.delivery_area_id = 1
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Delivery area can't be blank")
      end
      it '市区町村が空では購入できない' do
        @purchase_delivery.city = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では購入できない' do
        @purchase_delivery.block = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空では購入できない' do
        @purchase_delivery.phone_number = ''
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が全角では購入できない' do
        @purchase_delivery.phone_number = '０９０１２３４５６７８'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号がハイフンを含むと購入できない' do
        @purchase_delivery.phone_number = '090-1234-5678'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が10桁より少ないと購入できない' do
        @purchase_delivery.phone_number = '123456789'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が11桁より多いと購入できない' do
        @purchase_delivery.phone_number = '123456789012'
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'ユーザーが紐付いていなければ登録できない' do
        @purchase_delivery.user_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐付いていなければ登録できない' do
        @purchase_delivery.item_id = nil
        @purchase_delivery.valid?
        expect(@purchase_delivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
