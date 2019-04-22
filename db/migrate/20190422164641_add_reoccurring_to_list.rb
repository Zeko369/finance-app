class AddReoccurringToList < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :reoccurring, :boolean, default: false
  end
end
