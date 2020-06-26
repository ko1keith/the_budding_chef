require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "olivia", email:"olivia@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegie sautee", description:"greate vegie sautee, add vegie and oil", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken sautee", description:"great chicken dish")
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "should get recipes index" do
    get chefs_path
    assert_response :success
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@chef2, "password")
    get chefs_path
    assert_template "chefs/index"
    assert_difference "Chef.count", -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end
