class IntervalsController < ApplicationController
  before_filter :authenticate

  def index
    @intervals = Interval.where(:task_id => params[:task_id]).all

    respond_to do |format|
      format.json { render :json => @intervals.to_json(:methods => %w{human_start human_stop human_count}) }
    end
  end

  def start
    if Interval.active(params[:task_id]).empty?
      @interval = Interval.create({:task_id => params[:task_id]})
      @interval.start!
    end
    render :nothing => true
  end

  def stop
    unless Interval.active(params[:task_id]).empty?
      @interval = Interval.active(params[:task_id]).first
      @interval.details = params[:interval][:details]
      @interval.stop!

      project_id = @interval.project.tb_id
      task_id = @interval.task.tb_id
      api_call = "curl -d \"project_id=#{project_id}&body=#{@interval.details}&hours=#{@interval.count}\" "
      api_call << "https://teambox.com/api/1/projects/#{project_id}/tasks/#{task_id}/comments "
      api_call << "-u #{@username}:#{@password}"
      p api_call
      system(api_call)
    end
    render :nothing => true
  end
end
