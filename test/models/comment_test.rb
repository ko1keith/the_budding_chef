require 'test_helper'

class CommentTest < ActiveSupport::TestCase

    def setup 
        @chef = Chef.create!(chefname: "Keith", email: "keith@gmail.com", password: "password", password_confirmation: "password")
        @recipe = Recipe.create(name: "Vegie sautee", description:"greate vegie sautee, add vegie and oil", chef: @chef)
        @comment = Comment.create!(description:"this is a comment", chef: @chef , recipe: @recipe)
    end

    test "chef should be valid" do
        assert @chef.valid?
    end

    test "comment should be valid" do
        assert @comment.valid?
    end

end