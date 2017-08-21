module Admin::ResumesHelper
  def resume_filters(options)
    params.permit(:status, :location_id).merge(options)
  end
end
