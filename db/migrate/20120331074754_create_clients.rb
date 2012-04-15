class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :fax
      t.string :website
      t.string :company_email      
      t.string :logo_file_name
      t.string :logo_content_type
      t.string :logo_file_size
      t.string :logo_updated_at
      t.integer :company_id
      t.string :comment
      
      t.timestamps
    end
  end
end
