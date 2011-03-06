class IntervalsController < ApplicationController
  def index
    @intervals = Interval.where(:task_id => params[:task_id]).all
    respond_to do |format|
      format.json { render :json => @intervals }
    end
  end

  def start
    @interval = Interval.create({:task_id => params[:task_id]})
    @interval.start!
    render :nothing => true
  end

  def stop
    @interval = Interval.where(:task_id => params[:task_id]).last
    @interval.stop!
    render :nothing => true
  end
end
