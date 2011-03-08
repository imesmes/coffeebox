class TasksController < ApplicationController
  before_filter :authenticate

  def index
    @tasks = Task.where(:project_id => params[:project_id]).all

    respond_to do |format|
      format.json { render :json => @tasks }
    end
  end
end
