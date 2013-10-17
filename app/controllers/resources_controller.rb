class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    r = Resource.new(name: "Alberto", owner: 0)
    logger.debug("r.attributes: #{r.attributes}")
    logger.debug("r.valid?: #{r.valid?}")
    # r.save
    # Faraday.post "http://srv1.csproj13.student.it.uu.se:8000/users/0/resources", r.attributes.to_json
    # Faraday.put "http://srv1.csproj13.student.it.uu.se:8000/users/0/resources/7F845um4SpCnmxpLm7SkFg/", { :name => 'Maguro' }
    @resources = Resource.all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    redirect_to :action => "edit"
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    t = Time.new
    # @resource.creation_date = t.year.to_s + '/' + t.month.to_s + '/' + t.day.to_s
    logger.debug ">> Create Resource: #{@resource}"
    respond_to do |format|
      if @resource.save
        format.html { redirect_to edit_resource_path(@resource) }
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
    @resource.update_attributes(resource_params)
    logger.debug ">> Resource: #{@resource.attributes}"
    # url = "http://srv1.csproj13.student.it.uu.se:8000/users/0/resources/7F845um4SpCnmxpLm7SkFg"
    #logger.debug url
    logger.debug("@resource.attributes.to_json: #{@resource.attributes.to_json}")
    res = Faraday.put "http://srv1.csproj13.student.it.uu.se:8000/users/0/resources/7F845um4SpCnmxpLm7SkFg/", @resource.attributes.to_json
    res.on_complete do
      if res
        format.html { redirect_to action: 'index', status: :moved_permanently }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:owner, :name, :description, :manufacturer, :model, :update_freq, :resource_type, :data_overview, :serial_num, :make, :location, :uri, :tags, :active)
    end
end
