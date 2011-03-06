require 'open-uri'

class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = teambox_api_call("/api/1/projects")

    respond_to do |format|
      format.json { render :json => @projects }
    end
  end
end
