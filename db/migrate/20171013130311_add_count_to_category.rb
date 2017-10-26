class AddCountToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :count, :integer
  end
end
