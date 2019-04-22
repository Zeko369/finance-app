class AddDirrectionToList < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :dirrection, :boolean, default: false
  end
end
