class IntervalsController < ApplicationController
  before_filter :authenticate

  def index
    @intervals = Interval.where(:task_id => params[:task_id]).all

    respond_to do |format|
      format.json { render :json => @intervals.to_json(:methods => %w{human_start human_stop count}) }
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
      teambox_api_call('create_project_task_comment', @interval.project.tb_id, @interval.task.tb_id, 
                       {'project_id' => @interval.project.tb_id, 'body' => @interval.details, 'hours' =>'10m'})
    end
    render :nothing => true
  end
end
