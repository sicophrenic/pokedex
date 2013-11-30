#-*- coding: utf-8 -*-#
class PoketypesController < ApplicationController
  before_action :require_signed_in
  before_action :require_admin
  before_action :set_poketype, only: [:show, :edit, :update, :destroy]

  # GET /poketypes
  # GET /poketypes.json
  def index
    @poketypes = Poketype.all
  end

  # GET /poketypes/1
  # GET /poketypes/1.json
  def show
  end

  # GET /poketypes/new
  def new
    @poketype = Poketype.new
  end

  # GET /poketypes/1/edit
  def edit
  end

  # POST /poketypes
  # POST /poketypes.json
  def create
    @poketype = Poketype.new(poketype_params)

    respond_to do |format|
      if @poketype.save
        format.html { redirect_to @poketype, notice: 'Poketype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @poketype }
      else
        format.html { render action: 'new' }
        format.json { render json: @poketype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poketypes/1
  # PATCH/PUT /poketypes/1.json
  def update
    respond_to do |format|
      if @poketype.update(poketype_params)
        format.html { redirect_to @poketype, notice: 'Poketype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @poketype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poketypes/1
  # DELETE /poketypes/1.json
  def destroy
    @poketype.destroy
    respond_to do |format|
      format.html { redirect_to poketypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poketype
      @poketype = Poketype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poketype_params
      params[:poketype]
    end
end
