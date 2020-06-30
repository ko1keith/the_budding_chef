require 'test_helper'

class IngredientTest <ActiveSupport::TestCase

    def setup
        @ingredient = Ingredient.create!(name: "mushroom")
    end

    test "ingredient should be valid" do
        assert @ingredient.valid?
    end

    test "ingredient name should be present" do 
        @ingredient.name = ""
        assert_not @ingredient.valid?
    end

    test "ingredient name should be greater then 3 characters" do
        @ingredient.name = "aa"
        assert_not @ingredient.valid?
    end

    test "ingredient name should be less then 25 characters" do
        @ingredient.name = "a" * 26
        assert_not @ingredient.valid?
    end

end