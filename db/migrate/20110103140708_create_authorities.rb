class CreateAuthorities < ActiveRecord::Migration
  def self.up
    create_table :authorities do |t|
      t.integer :user_id
      t.integer :problem_id
      t.integer :level
      t.timestamps
    end
  end

  def self.down
    drop_table :authorities
  end
end
