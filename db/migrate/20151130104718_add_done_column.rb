class AddDoneColumn < ActiveRecord::Migration
  def change
     add_column :items, :done, :boolean, :null => false, :default => false
  end
end
