class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :type,             :default => nil
      t.string :role
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.string :fax
      t.string :website
      t.integer :company_id,      :default => nil
      t.integer :project_id
      t.boolean :status,          :default => nil
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end