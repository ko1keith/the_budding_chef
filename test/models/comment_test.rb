require 'test_helper'

class CommentTest < ActiveSupport::TestCase

    def setup 
        @chef = Chef.create(chefname: "keith", email:"keith@example.com", password: "password", password_confirmation: "password")
        @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
        @comment = Comment.create!(description:"this is a comment", chef_id: @chef, recipe_id: @recipe)
    end

    test "comment should be valid" do
        assert @comment.valid?
    end

end