class ClientsController < ApplicationController
  
  before_filter :find_current_user
  before_filter :find_client, :only => [:destroy, :edit, :update, :show]
  
  def index
    @clients = Client.all
  end
  
  def new
    @client = Client.new
    @contact_person = ContactPerson.new
    @client.contact_person = @contact_person
  end
  
  def create
    @client = Client.new(params[:client])
   
    @client.contact_person = ContactPerson.new(params[:client][:contact_person_attributes])
    if @client.save 
      flash[:notice] = "Client has been created successfully."
      redirect_to clients_path
    else
      render :action => :new
    end    
  end
  
  def destroy
    flash[:notice] = "Client has been deleted successfully." if @client.destroy
    redirect_to clients_path
  end
  
  def edit    
  end
  
  def show
    
  end
  
  def update
    if @client.update_attributes(params[:client]) 
      flash[:notice] = "Client has been updated successfully."
      redirect_to clients_path
    else
      render :action => :edit
    end    
  end
  
  private
  def find_client
    @client = Client.find_by_id(params[:id])   
    flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and redirect_to clients_path and return unless @client 
  end
  
  def find_current_user
    flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and redirect_to login_path and return unless current_user.present? 
  end
  
end
