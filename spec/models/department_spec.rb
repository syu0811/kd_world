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

      it "alphabetが１文字ではないと失敗する" do
        department = build(:department, alphabet: "AA")
        department.valid?
        expect(department.errors[:alphabet]).to include('は1文字で入力してください')
      end

      it "alphabetが英字かつ大文字ではないと失敗する" do
        department = build(:department, alphabet: "a")
        department.valid?
        expect(department.errors[:alphabet]).to include('は不正な値です')
      end
    end
  end
end
