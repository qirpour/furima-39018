require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号にはハイフン(-)を含めて入力してください')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'cityが空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空だと保存できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'telephoneが空だと保存できないこと' do
        @order_address.telephone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'telephoneにハイフンが含まれていると保存できないこと' do
        @order_address.telephone = '000-0000-0000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号には半角数字のみを入力してください')
      end
      it 'telephoneが9桁以下だと保存できないこと' do
        @order_address.telephone = '0000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号には半角数字のみを入力してください')
      end
      it 'telephoneが12桁以上だと保存できないこと' do
        @order_address.telephone = '0000000000000000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号には半角数字のみを入力してください')
      end
      it 'telephoneに半角数字以外が含まれていると保存できないこと' do
        @order_address.telephone = 'テスト'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号には半角数字のみを入力してください')
      end
      it 'itemが紐づいていなければ登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'userが紐づいていなければ登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
