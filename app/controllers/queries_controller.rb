class QueriesController < ApplicationController

  before_action :set_query, only: [:show]

  # GET /queries/1
  # GET /queries/1.json
  def show
  end

  # GET /queries/new
  def new
    @query = Query.new
    service = ChuckNorrisService.get_instance

    @categories = service.categories(@query)
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(query_params)

    service = ChuckNorrisService.get_instance
    service.query(@query)

    if @query.mail?
      QueryMailer.basic(@query).deliver
    end

    respond_to do |format|
      if @query.save
        format.html { redirect_to @query, notice: 'Query was successfully created.' }
        format.js {render :create}
      else
        format.html { render :new }
        format.js { render :create }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:kind, :words, :category, 
        :send_to_mail)
    end
end
