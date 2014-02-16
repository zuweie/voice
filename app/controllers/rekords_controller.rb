class RekordsController < ApplicationController
  # GET /rekords
  # GET /rekords.json
  def index
    @rekords = Rekord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rekords }
    end
  end

  # GET /rekords/1
  # GET /rekords/1.json
  def show
    @rekord = Rekord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rekord }
    end
  end

  # GET /rekords/new
  # GET /rekords/new.json
  def new
    @rekord = Rekord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rekord }
    end
  end

  # GET /rekords/1/edit
  def edit
    @rekord = Rekord.find(params[:id])
  end

  # POST /rekords
  # POST /rekords.json
  def create
    @rekord = Rekord.new(params[:rekord])

    respond_to do |format|
      if @rekord.save
        format.html { redirect_to @rekord, notice: 'Rekord was successfully created.' }
        format.json { render json: @rekord, status: :created, location: @rekord }
      else
        format.html { render action: "new" }
        format.json { render json: @rekord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rekords/1
  # PUT /rekords/1.json
  def update
    @rekord = Rekord.find(params[:id])

    respond_to do |format|
      if @rekord.update_attributes(params[:rekord])
        format.html { redirect_to @rekord, notice: 'Rekord was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rekord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rekords/1
  # DELETE /rekords/1.json
  def destroy
    @rekord = Rekord.find(params[:id])
    @rekord.destroy

    respond_to do |format|
      format.html { redirect_to rekords_url }
      format.json { head :ok }
    end
  end
end
