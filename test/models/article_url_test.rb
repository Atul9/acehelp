# frozen_string_literal: true

require "test_helper"

class ArticleUrlTest < ActiveSupport::TestCase
  def setup
    @article = articles :life
    @url = urls :google
  end

  test "add url for article" do
    article_url_count = ArticleUrl.count
    @article.urls << @url

    assert_equal ArticleUrl.count, article_url_count + 1
  end
end
