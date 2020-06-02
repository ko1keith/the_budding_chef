require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com")
    @recipe = Recipe.create(name: "Vegie sautee", description:"greate vegie sautee, add vegie and oil", chef: @chef)
  end

  test "successfully delete a recipe" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@Recipe)
    end
    assert_redirected_t- recipes_path
    assert_not flash.empty?

  end
end
