include ActionView::Helpers::DateHelper

class Interval < ActiveRecord::Base
  def start!
    self.update_attribute(:start, DateTime.now)
  end

  def stop!
    self.update_attribute(:stop, DateTime.now)
  end

  def count
    distance_of_time_in_words(self.start,self.stop)
  end
end
