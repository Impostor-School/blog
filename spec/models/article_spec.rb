require 'rails_helper'

RSpec.describe Article, type: :model do
  it "should be valid with correct input" do
    article = Article.new(title: "Hello Rails", body: "I am on Rails!")
    expect(article).to be_valid
  end

  it "should be valid when using a factory" do
    article = build(:article)
    expect(article).to be_valid
  end

  context "is invalid" do
    it "without a title" do
      article = build(:article, title: nil)
      article.valid?
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "without a body" do
      article = build(:article, body: nil)
      article.valid?
      expect(article.errors[:body]).to include("can't be blank")
    end

    it "when body is less than 10 characters" do
      article = build(:article, body: "Short")
      article.valid?
      expect(article.errors[:body]).to include("is too short (minimum is 10 characters)")
    end
  end
end
