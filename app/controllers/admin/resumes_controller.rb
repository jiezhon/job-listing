class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  before_action :find_job

  def index
    # @job = Job.find(params[:job_id])
    # @resumes = @job.resumes.order('id DESC').page(params[:page])
    @q = @job.resumes.ransack(params[:q])

    @resumes = @q.result.includes(:location).order("id DESC").page(params[:page])

    if params[:status].present? && Resume::STATUS.include?(params[:status])
      @resumes = @resumes.by_status(params[:status])
    end

    if params[:location_id].present?
      @resumes = @resumes.by_location(params[:location_id])
    end

    if params[:start_on].present?
      @resumes = @resumes.where("created_at >= ?", Date.parse(params[:start_on]).beginning_of_day)
    end

    if params[:end_on].present?
      @resumes = @resumes.where("created_at <= ?", Date.parse(params[:end_on]).end_of_day)
    end

    if params[:resume_id].present?
      @resumes = @resumes.where( :id => params[:resume_id].split(","))
    end

    if Array(params[:statuses]).any?
      @resumes = @resumes.by_status(params[:statuses])
    end

    if Array(params[:location_ids]).any?
      @resumes = @resumes.by_location(params[:location_ids])
    end

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
