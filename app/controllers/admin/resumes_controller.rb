class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  before_action :find_job

  def index
    # @job = Job.find(params[:job_id])
    @resumes = @job.resumes.order('created_at DESC').page(params[:page])
  end

  def edit
    @resume = @job.resumes.find_by_uuid(params[:id])
  end

  def update
    @resume = @job.resumes.find_by_uuid(params[:id])
    @resume.status = "confirmed"
    
    if @resume.update(resume_params)
      redirect_to admin_job_resumes_path(@job)
    else
      render "edit"
    end
  end

  def destroy
    @resume = @job.resumes.find_by_uuid(params[:id])
    @resume.destroy

    redirect_to admin_job_resumes_path(@job)
  end

  private
  def resume_params
    params.require(:resume).permit(:content, :attachment, :name, :email, :cellphone, :location_id)
  end

  def find_job
    @job = Job.find(params[:job_id])
  end

end
