class ModifyLanguageType < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :language, :integer, default: 0
  end
end
