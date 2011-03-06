class TasksController < ApplicationController
  before_filter :authenticate

  def index
    @tasks = teambox_api_call("/api/1/projects/#{params[:project_id]}/tasks")

    respond_to do |format|
      format.json { render :json => @tasks }
    end
  end
end
