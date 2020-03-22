class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.string :delivery
      t.string :signature
      t.json :payload

      t.timestamps
    end
  end
end
