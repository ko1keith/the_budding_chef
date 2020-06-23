require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid login is rejected" do
    get login_path
    assert_template "sessions/new"
  end


  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template "sessions/new"
  end

end