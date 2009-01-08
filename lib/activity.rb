class Activity
  belongs_to :actor, :class_name => 'User'
  validates_presence_of :action
end