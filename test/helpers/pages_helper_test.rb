require 'test_helper'

class PagesHelperTest < ActionController::TestCase
  include PagesHelper

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  test "print_search_result return no results for empty container" do
    search_word = 'Hei'
    result = print_search_result search_word, {}
    assert_equal "No results for '#{search_word}'", result
  end

  test "search returns correct amount of results" do
    max_results = 50
    searchword = 'you'
    result = search searchword, max_results
    assert_equal max_results, result.count
  end

end
