class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.text :topic, null: false
      t.date :date, null: false
      t.string :time
      t.string :via, default: "email", null: false
      t.integer :contact_id, null: false

      t.timestamps
    end
  end
end
