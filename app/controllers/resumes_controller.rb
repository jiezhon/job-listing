class ResumesController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end

  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.create(resume_params)
    @resume.location = @job.locations.find(params[:resume][:location_id])
    @resume.status = "confirmed"
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      redirect_to job_path(@job), notice: 'Resume added'
    else
      render :new
    end
  end

  private
  def resume_params
    params.require(:resume).permit(:content, :attachment, :name, :email, :cellphone, :location_id)
  end

end
