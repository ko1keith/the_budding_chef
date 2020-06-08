require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com", password: "password", password_confirmation: "password")
  end

  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "", email: "keith@example.com"}}
    assert_template 'chefs/edit'   # should still get chefs edit page after failed attemp to signup
    assert_select 'h2.card-title'  # check for error partial
    assert_select 'div.card-body'
  end

  test "accept a valid signup" do
    get signup_path
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: {chefname: "Keith", email: "keith@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Keith", @chef.chefname
    assert_match "keith@example.com", @chef.email
  end


end
