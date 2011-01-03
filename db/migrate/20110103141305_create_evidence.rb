class CreateEvidences < ActiveRecord::Migration
  def self.up
    create_table :evidence do |t|
      t.integer :opinion_id
      t.string :opinion_type
      t.integer :evidence_id
      t.string :evidence_type

      t.timestamps
    end
  end

  def self.down
    drop_table :evidence
  end
end
