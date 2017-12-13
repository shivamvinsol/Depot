class ChangeDataTypeOfRating < ActiveRecord::Migration[5.0]
  def change
    change_column :ratings, :rating, :decimal, precision: 2, scale: 1
  end
end
