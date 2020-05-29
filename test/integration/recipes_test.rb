require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com")
    @recipe = Recipe.create(name: "Vegie sautee", description:"greate vegie sautee, add vegie and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken sautee", description:"great chicken dish")
    @recipe2.save
  end

  test "should get recipe index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Chicken saute"
    description_of_recipe = "add chicken, add vegies, cook for 20 minutes, serve meal"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe:{name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params:{recipe: {name:" ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'

  end


end
