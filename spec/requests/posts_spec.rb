require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let(:area) { create(:area) }
  let(:category) { create(:category) }

  describe "CURD機能の確認" do
    before { sign_in user }

    context "投稿作成(create)" do
      it "正しいパラメータの場合、投稿が作成される" do
        expect do
          post posts_path, params: {
            post: {
              name: "テスト動物",
              title: "テストタイトル",
              body: "テスト本文",
              area_id: area.id
                  },
            category: category.name
                }
      end.to change(Post, :count).by(1)

      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(flash[:notice]).to eq "投稿に成功しました"
      end
    end

    context "投稿編集(update)" do
      it "正しいパラメータの場合、投稿が編集される" do
        patch post_path(user_post), params: {
          post: {
            name: "テスト編集",
            title: "テスト編集",
            body: "テスト本文",
            area_id: area.id
                },
          category: category.name
              }
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq "編集に成功しました"
      end
    end

    context "投稿削除(delete)" do
      it "正しいパラメータの場合、投稿が削除される" do
        user_post
        expect do
        delete post_path(user_post)
      end.to change(Post, :count).by(-1)

        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to eq "削除に成功しました"
      end
    end
  end
end
