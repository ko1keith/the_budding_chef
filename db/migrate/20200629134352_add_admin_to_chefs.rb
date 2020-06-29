class AddAdminToChefs < ActiveRecord::Migration[6.0]
  def change
    # change chefs table, add admin attribute, of type boolean, with default attribute of false
    add_column :chefs, :admin, :boolean, default: false
  end
end
