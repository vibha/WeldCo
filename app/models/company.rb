class Company < ActiveRecord::Base
  
  has_one :contact_person, :dependent => :destroy
  
  has_attached_file :logo
  has_many :clients, :dependent => :destroy
  has_many :users, :dependent => :destroy
  
  validates_presence_of :name
end
