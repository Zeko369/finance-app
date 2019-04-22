class AddMonthToExpense < ActiveRecord::Migration[6.0]
  def change
    add_reference :expenses, :month, foreign_key: true
  end
end
