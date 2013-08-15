class CreateStash < ActiveRecord::Migration
  def change
  	create_table :stashes do |t|
  		t.string :name
  		t.string :practice
  		t.string :email
  		t.string :phone
  		t.text :body
  	end
  end
end
