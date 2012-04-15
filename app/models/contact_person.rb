class ContactPerson < ActiveRecord::Base
  
 # belongs_to :member, :polymorphic => true
 # has_one :account, :class_name => "User", :conditions => "type='contact_person'"
  
#  accepts_nested_attributes_for :member
  
  belongs_to :client
  belongs_to :company
  
  validates_presence_of :name, :address, :phone, :email
  validates_uniqueness_of :email
  
end
