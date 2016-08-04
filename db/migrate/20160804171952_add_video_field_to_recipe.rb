class AddVideoFieldToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :video, :string
  end
end
