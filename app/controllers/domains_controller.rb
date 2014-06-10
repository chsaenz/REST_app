require 'socket'

class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]
  before_filter :load_account

  # GET /domains
  # GET /domains.json
  def index
    @domains = @account.domains.all

  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    @domain = @account.domains.find(params[:id])
  end

  # GET /domains/new
  def new
    @domain = @account.domains.new
  end

  # GET /domains/1/edit
  def edit
    @domain = @account.domains.find(params[:id])
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = @account.domains.new(domain_params)
      @domain.account_id = params[:account_id]

      respond_to do |format|
        if @domain.save
          DomainsWorker.perform_async(@domain.id)
          format.html { redirect_to [@account, @domain], notice: 'Domain was successfully created.' }
          format.json { render :show, status: :created, location: @domain }
        else
          format.html { render :new }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      end
  end

  def catch_error(domain)

  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    @domain.hostname = params[:domain][:hostname]

    respond_to do |format|
      if @domain.update(domain_params)
        DomainsWorker.perform_async(@domain.id)
        format.html { redirect_to [@account, @domain], notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain = @account.domains.find(params[:id])
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to account_domains_path(@account), notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:hostname, :origin_ip_address, :account_id)
    end

    def load_account
      @account = Account.find(params[:account_id])
    end
end
