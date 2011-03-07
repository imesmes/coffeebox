require 'net/https'

class TeamboxController < ApplicationController
  before_filter :authenticate

  def sync
    projects = teambox_api_call('projects')
    projects.objects.each do |p|
      project = Project.find_or_create_by_tb_id(p["id"]) 
      project.update_attributes({ :name => p["name"] })
      tasks = teambox_api_call('project_tasks',project.tb_id)
      tasks.objects.each do |t|
        task = project.tasks.find_or_create_by_tb_id(t["id"])
        task.update_attributes({ :name => t["name"] })
      end
    end
    render :nothing => true
  end
end
