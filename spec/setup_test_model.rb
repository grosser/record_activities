require 'rubygems'
require 'active_record'

#create model table
ActiveRecord::Schema.define(:version => 1) do
  create_table "users" do |t|
  end
  create_table "comments" do |t|
    t.string :text, :null=>false
  end
  create_table "activities" do |t|
    t.integer :actor_id, :null=>false
    t.integer :subject_id, :null=>false
    t.string :subject_type, :null=>false
    t.string :action, :null=>false
    t.timestamp :created_at, :null=>false
  end
end

#create models
class User < ActiveRecord::Base
  model_stamper
end
class Comment < ActiveRecord::Base
  validates_presence_of :text
  stampable
  record_activities
end
#same but with custom activities
class Comment2 < ActiveRecord::Base
  set_table_name :comments
  stampable
  record_activities :foo, :bar
end
require 'activity'