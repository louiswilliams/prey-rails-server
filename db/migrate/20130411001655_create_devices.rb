class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :device_id, :uniq => true 
      t.integer :account
      t.string :name
      t.integer :delay, :default => 20
      t.string :modules, :default => "geo module module"
      t.boolean :missing, :default => false

      t.timestamps
    end
  end
end
