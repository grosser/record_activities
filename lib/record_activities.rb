class ActiveRecord::Base
  def self.record_activities(*activities)
    include RecordActivities::InstanceMethods
    activities.each do |activity|
      send("before_#{activity}","record_activities_#{activity}".to_sym)
    end
  end
end

module RecordActivities
  module InstanceMethods
    def record_activities_create
      Activity.create(:actor=>self.class.stamper_class.stamper,:action=>'create')
    end
    def record_activities_update
      Activity.create(:actor=>self.class.stamper_class.stamper,:action=>'update')
    end
  end
end