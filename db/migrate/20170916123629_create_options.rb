class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.integer :no
      t.string :name
      t.boolean :answer
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
