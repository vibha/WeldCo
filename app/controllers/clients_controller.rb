class ClientsController < ApplicationController
  
  before_filter :current_user
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(params[:client])
    if @client.save 
      flash[:notice] = "Client has been created successfully."
      redirect_to "/"
    else
      render :action => :new
    end    
  end
end
