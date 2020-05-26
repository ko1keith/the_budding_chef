require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get recipe index" do
    get recipes_path
    assert_response :success
  end

end
