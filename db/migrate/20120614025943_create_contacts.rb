class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :lastname, null: false
      t.string :email, null: false
      t.string :skypeid
      t.string :phone
      t.boolean :wish_info, default: true, null: false

      t.timestamps
    end
  end
end
