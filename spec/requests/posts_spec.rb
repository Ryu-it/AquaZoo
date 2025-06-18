require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "CURD機能の確認" do
    before do
    user = User.create!(email: "test@example.com", password: "password")
    sign_in user
    end

    context "投稿作成(create)" do
      it "正しいパラメータの場合、投稿が作成される" do
        expect do
          area = Area.create!(name: "関東")
          category = Category.create!(name: "zoo")

          post posts_path, params: {
            post: {
              name: "テスト動物",
              title: "テストタイトル",
              body: "テスト本文",
              area_id: area.id
          },
            category: "zoo"
        }
      end.to change(Post, :count).by(1)

      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(flash[:notice]).to eq "投稿に成功しました"
      end
    end
  end
end
