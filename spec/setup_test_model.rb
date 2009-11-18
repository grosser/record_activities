# connect
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

# create model table
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
  end

  create_table :comments do |t|
    t.string :text, :null=>false
  end

  create_table :activities do |t|
    t.integer :actor_id, :null=>false
    t.integer :subject_id, :null=>false
    t.string :subject_type, :null=>false
    t.string :action, :null=>false
    t.timestamp :created_at, :null=>false
  end
end

# create models
class User < ActiveRecord::Base
  model_stamper
end

class Comment < ActiveRecord::Base
  validates_presence_of :text
  stampable
  record_activities
end

# like Comment but with custom activities
class Comment2 < ActiveRecord::Base
  set_table_name :comments
  stampable
  record_activities :foo, :bar, :dependent=>:destroy
end

# like Comment but custom name for activities
class Comment3 < ActiveRecord::Base
  set_table_name :comments
  stampable
  record_activities :association=>:things_i_did
end