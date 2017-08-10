class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_is_admin
  layout "admin"

  def index
    @jobs = Job.rank(:row_order).all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @job.locations.build
  end

  def create
    @job = Job.create(job_params)

    if @job.save
      redirect_to admin_jobs_path, notice: 'Job created'
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
    @job.locations.build if @job.locations.empty?
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to admin_jobs_path, notice: 'Job updated'
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_path, alert: 'Job deleted'
  end

  def publish
    @job = Job.find(params[:id])
    @job.publish!
    redirect_to :back
  end

  def hide
    @job = Job.find(params[:id])
    @job.hide!
    redirect_to :back
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |job_id|
      job = Job.find(job_id)
      if params[:commit] == I18n.t(:bulk_update)
        job.is_hidden = params[:job_is_hidden]
        if job.save
          total += 1
        end
      else
        job.destroy
        total += 1
      end
    end

    flash[:alert] = "Successfully processed #{total} Jobs"
    redirect_to admin_jobs_path
  end

  def reorder
    @job = Job.find(params[:id])
    @job.row_order_position = params[:position]
    @job.save!

    #redirect_to admin_jobs_path
    respond_to do |format|
      format.html { redirect_to admin_jobs_path }
      format.json { render :json => { :message => "ok" }}
    end
  end

  private
  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden,
                                :locations_attributes => [:id, :city, :address, :quantity, :_destroy])
  end

end
