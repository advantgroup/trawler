class AddThings < ActiveRecord::Migration
  def change
  	change_table :stashes do |t|
  		t.string :fax
  		t.string :address
  	end
  end
end
