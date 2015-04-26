class ProjectUpdatesController < ApplicationController
  before_action :set_project_update, only: [:show, :edit, :update, :destroy]

  # GET /project_updates
  # GET /project_updates.json
  def index
    @project_updates = ProjectUpdate.all
  end

  # GET /project_updates/1
  # GET /project_updates/1.json
  def show
  end

  # GET /project_updates/new
  def new
    @project_update = ProjectUpdate.new
  end

  # GET /project_updates/1/edit
  def edit
  end

  # POST /project_updates
  # POST /project_updates.json
  def create
    @project_update = ProjectUpdate.new(project_update_params)

    respond_to do |format|
      if @project_update.save
        format.html { redirect_to @project_update, notice: 'Project update was successfully created.' }
        format.json { render :show, status: :created, location: @project_update }
      else
        format.html { render :new }
        format.json { render json: @project_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_updates/1
  # PATCH/PUT /project_updates/1.json
  def update
    respond_to do |format|
      if @project_update.update(project_update_params)
        format.html { redirect_to @project_update, notice: 'Project update was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_update }
      else
        format.html { render :edit }
        format.json { render json: @project_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_updates/1
  # DELETE /project_updates/1.json
  def destroy
    @project_update.destroy
    respond_to do |format|
      format.html { redirect_to project_updates_url, notice: 'Project update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_update
      @project_update = ProjectUpdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_update_params
      params.require(:project_update).permit(:project_id, :description)
    end
end
