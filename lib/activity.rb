class Activity < ActiveRecord::Base
  belongs_to :actor, :class_name => 'User'
  belongs_to :subject, :polymorphic => true

  validates_presence_of :action
end