class CreateMonths < ActiveRecord::Migration[6.0]
  def change
    create_table :months do |t|
      t.integer :month, null: false
      t.integer :year, null: false

      t.timestamps
    end
  end
end
