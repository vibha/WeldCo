class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :phone
      t.string :fax
      t.string :website
      t.string :company_email
      t.string :contact_person_name
      t.string :comment
      
      t.timestamps
    end
  end
end
