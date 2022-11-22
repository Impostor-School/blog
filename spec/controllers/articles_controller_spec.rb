require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    let(:article) { create(:article) }

    it "responds successfully" do
      get :show, params: {id: article.id}
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :show, params: {id: article.id}
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do  
    context "when valid" do
      it "adds an article" do
        article_params = attributes_for(:article)
        expect {
          post :create, params: { article: article_params }
        }.to change(Article, :count).by(1)
      end
    end

    context "when invalid" do
      it "doesn't add an article" do
        article_params = attributes_for(:article, title: nil)
        expect {
          post :create, params: { article: article_params }
        }.to change(Article, :count).by(0)
      end
    end
  end

  describe "#update" do 
    let(:article) { create(:article) }

    it "updates an article" do
      article_params = attributes_for(:article, title: "New Title")

      patch :update, params: { id: article.id, article: article_params}
      expect(article.reload.title).to eq("New Title")
    end
  end

  describe "#destroy" do
    let!(:article) { create(:article) }

    it "removes an article" do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)
    end
  end
end
