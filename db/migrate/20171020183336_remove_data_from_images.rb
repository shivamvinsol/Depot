class RemoveDataFromImages < ActiveRecord::Migration[5.0]
  def change
    remove_column :images, :data, :string
  end
end
