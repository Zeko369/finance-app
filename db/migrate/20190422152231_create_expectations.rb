class CreateExpectations < ActiveRecord::Migration[6.0]
  def change
    create_table :expectations do |t|
      t.belongs_to :list, foreign_key: true
      t.belongs_to :month, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
