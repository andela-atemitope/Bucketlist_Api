class AddDoneColumn < ActiveRecord::Migration
  def change
     add_column :item, :done, :boolean, :null => false, :default => false
  end
end
