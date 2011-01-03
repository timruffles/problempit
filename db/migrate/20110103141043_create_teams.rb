class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.text :summary
      t.integer :hiring
      t.integer :funding

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
