class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.integer :company_id
      t.integer :client_id
      
      t.timestamps
    end
  end
end
