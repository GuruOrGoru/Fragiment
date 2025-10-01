require "test_helper"

class SnippetTest < ActiveSupport::TestCase
  test "should not save snippet without title" do
    user = users(:one)
    snippet = Snippet.new(code: "puts 'hello'", language: "Ruby", user: user)
    assert_not snippet.save
  end

  test "should save snippet with required fields" do
    user = users(:one)
    snippet = Snippet.new(title: "Test Snippet", code: "puts 'hello'", language: "Ruby", user: user)
    assert snippet.save
  end

  test "snippet belongs to user" do
    user = users(:one)
    snippet = Snippet.new(title: "Test Snippet", code: "puts 'hello'", language: "Ruby", user: user)
    assert snippet.save
    assert_equal user, snippet.user
  end

  test "snippet has many likes" do
    user = users(:one)
    snippet = Snippet.create(title: "Test Snippet", code: "puts 'hello'", language: "Ruby", user: user)
    like = Like.create(user: user, snippet: snippet)
    assert_includes snippet.likes, like
  end

  test "snippet has many suggestions" do
    user = users(:one)
    snippet = Snippet.create(title: "Test Snippet", code: "puts 'hello'", language: "Ruby", user: user)
    suggestion = Suggestion.create(content: "Nice snippet", user: user, snippet: snippet)
    assert_includes snippet.suggestions, suggestion
  end
end
