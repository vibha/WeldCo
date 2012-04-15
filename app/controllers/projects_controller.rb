class ProjectsController < ApplicationController
  
  before_filter :find_current_user
  before_filter :find_project, :only => [:destroy, :edit, :update, :show]
  
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @clients_names = Client.all(&:name)
    @project.project_manager_projects_record = ProjectManagerProjectsRecord.new()
    @project.client_contact_person = User.new()
    @project.class_society_contact_person = User.new()
    @project.welding_coordinator = User.new()
        
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end
  
  def get_json
    client = Client.find(params[:client_id])
    render :text => client.to_json
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.project_manager_projects_record = ProjectManagerProjectsRecord.new(params[:project][:project_manager_projects_record_attributes])
    @project.client_contact_person = User.new(params[:project][:client_contact_person_attributes])
    @project.class_society_contact_person = User.new(params[:project][:class_society_contact_person_attributes])
    @project.welding_coordinator = User.new(params[:project][:welding_coordinator_attributes])
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
  
  private
  def find_project
    @project = Project.find_by_id(params[:id])   
    flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and redirect_to projects_path and return unless @project 
  end
  
  def find_current_user
    flash[:error] = PAGE_NOT_FOUND_ERROR_MESSAGE and redirect_to login_path and return unless current_user.present? 
  end
  
end
