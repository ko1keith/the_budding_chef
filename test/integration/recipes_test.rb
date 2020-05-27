require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com")
    @recipe = Recipe.create(name: "vegie sautee", description:"greate vegie sautee, add vegie and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken sautee", description:"great chicken dish")
    @recipe2.save
  end

  test "should get recipe index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body

  end

end
