class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :amount
      t.belongs_to :list, foreign_key: true

      t.timestamps
    end
  end
end
