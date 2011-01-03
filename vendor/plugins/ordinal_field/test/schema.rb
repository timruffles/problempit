ActiveRecord::Schema.define(:version => 1) do
  create_table :conversations, :force => true do |t|
    t.column :state_machine, :string
    t.column :subject,       :string
    t.column :closed,        :boolean
  end
  
  create_table :a_records, :force => true do |t|
    t.integer :goons
  end
end