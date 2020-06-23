require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname: "keith", email:"keith@example.com", password:"password")
  end

  test "invalid login is rejected" do
    get login_path
    assert_template "sessions/new"
    post login_path, params:{session: {email:"", password:""}}
    #expect new template to show up again
    assert_template 'sessions/new'
    #assert flash message from invalid login attempt
    assert_not flash.empty?
    #get different path and assert flash is not showing
    get root_path
    assert flash.empty?
  end


  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {email: @chef.email, password: @chef.password}}
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end

end
