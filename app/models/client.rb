class Client < ActiveRecord::Base

      validates_presence_of :name, :address, :zip_code, :city, :state, :country, :phone, :company_email, :logo_file_name
  validates_uniqueness_of  :logo_file_name, :company_email
  validates :zip_code, :phone, :numericality => true
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_one :contact_person, :dependent => :destroy
 # has_one :account, :class_name => "User"#, :conditions => "type='client'"
     
  accepts_nested_attributes_for :contact_person
 # accepts_nested_attributes_for :account
  
  belongs_to :company

  def validate
    self.errors.add_to_base("Logo can't be blank") if self.logo_file_name.blank?
  end

end
