require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'Validation' do
    context '正常系' do
      it "成功する" do
        department = build(:department)
        expect(department).to be_valid
      end
    end

    context '異常系' do
      it "nameが無ければ失敗する" do
        department = build(:department, name: nil)
        department.valid?
        expect(department.errors[:name]).to include('を入力してください')
      end

      it "alphabetが無ければ失敗する" do
        department = build(:department, alphabet: nil)
        department.valid?
        expect(department.errors[:alphabet]).to include('を入力してください')
      end

      it "alphabetが2文字以内ではないと失敗する" do
        department = build(:department, alphabet: "A" * 3)
        department.valid?
        expect(department.errors[:alphabet]).to include('は2文字以内で入力してください')
      end

      it "alphabetが英字かつ大文字ではないと失敗する" do
        department = build(:department, alphabet: "a")
        department.valid?
        expect(department.errors[:alphabet]).to include('は不正な値です')
      end
    end
  end
end
