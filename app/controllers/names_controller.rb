class NamesController < ApplicationController
  before_action :set_name, only: %i[ show edit update destroy ]

  # GET /names or /names.json
  def index
    @names = Name.all
  end

  # GET /names/1 or /names/1.json
  def show
  end

  # GET /names/new
  def new
    @name = Name.new
  end

  # GET /names/1/edit
  def edit
  end

  # POST /names or /names.json
  def create
    @name = Name.new(name_params)

    respond_to do |format|
      if @name.save
        format.html { redirect_to name_url(@name), notice: "Name was successfully created." }
        format.json { render :show, status: :created, location: @name }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /names/1 or /names/1.json
  def update
    respond_to do |format|
      if @name.update(name_params)
        format.html { redirect_to name_url(@name), notice: "Name was successfully updated." }
        format.json { render :show, status: :ok, location: @name }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /names/1 or /names/1.json
  def destroy
    @name.destroy!

    respond_to do |format|
      format.html { redirect_to names_url, notice: "Name was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name
      @name = Name.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def name_params
      params.require(:name).permit(:name)
    end
end
