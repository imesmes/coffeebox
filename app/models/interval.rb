include ActionView::Helpers::DateHelper

class Interval < ActiveRecord::Base
  belongs_to :task
  default_scope order('start DESC')

  scope :active, lambda { |task_id| where(:task_id => task_id).where(:stop => nil) }
  
  def start!
    self.update_attribute(:start, DateTime.now)
  end

  def stop!
    self.update_attribute(:stop, DateTime.now)
  end

  def count
    return nil if self.stop.nil?
    distance_of_time_in_words(self.start,self.stop)
  end

  def human_start
    return nil if self.start.nil?
    self.start.to_s(:long)
  end

  def human_stop
    return nil if self.stop.nil?
    self.stop.to_s(:long)
  end

  # Delegate method to task
  def project
    self.task.project
  end
end
