class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :provider, index: true
      t.belongs_to :category, index: true
      t.string :name
      t.string :twitter

      t.timestamps
    end
  end
end
