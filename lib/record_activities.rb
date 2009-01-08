class ActiveRecord::Base
  def self.record_activities(*actions)
    actions = [:create,:update] if actions.empty?
    actions.each do |action|
      method = "record_activities_#{action}".to_sym
      define_method method do
        Activity.create(:actor_id=>self.class.stamper_class.stamper,:subject=>self,:action=>action)
      end
      send("before_#{action}",method) if respond_to?("before_#{action}")
    end
  end
end