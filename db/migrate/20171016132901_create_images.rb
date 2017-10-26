class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.string :content_type
      t.binary :data, limit: 1.megabyte

      t.timestamps
    end
  end
end
