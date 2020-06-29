require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "olivia", email:"olivia@example.com", password: "password", password_confirmation: "password")
    @admin = Chef.create!(chefname: "john", email:"john@example.com", password: "password", password_confirmation: "password", admin: true)

  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "", email: "keith@example.com"}}
    assert_template 'chefs/edit'   # should still get chefs edit page after failed attemp to signup
    assert_select 'h2.card-title'  # check for error partial
    assert_select 'div.card-body'
  end

  test "accept a valid signup" do
    sign_in_as(@chef, "password")
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

  test "accept edit attempt by admin user" do
    sign_in_as(@admin, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: {chefname: "Keith3", email: "keith3@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Keith3", @chef.chefname
    assert_match "keith3@example.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: {chef: {chefname: updated_name, email: updated_email}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "keith", @chef.chefname
    assert_match "keith@example.com", @chef.email
  end


end
