 - Simple activity logging build on top of [userstamp](http://github.com/delynn/userstamp)
 - Does not involve the controller
 - Stores an Activity(:action, :actor, :subject) in the database
 - Supports :create, :update, :save and :destroy by default + any user-defined action

Setup
=====
 - Install and setup [userstamps](http://github.com/delynn/userstamp)
 - ` script/plugin install git://github.com/grosser/record_activities.git `
 - Create an activities table for your database (see: [MIGRATION](http://github.com/grosser/record_activities/blob/master/MIGRATION))
 - (Optional) Add `has_many :activities, :dependent => :destroy, :foreign_key => :actor_id` to your user

Usage
=====

    class Comment < ActiveRecord::Base
      stampable
      record_activities :dependent => :destroy
    end
    Comment.create! --> Activity.create!(:subject => comment, :actor => current_user, :action => 'create')

`record_activities` is the same as `record_activities :create, :update`.  
You may also use anything other than the supported `:create / :update / :save / :destroy`, but be sure to call the appropriate  
callback `model.record_activity_foo` when the action `foo` was performed.

A Comment `has_many :activities`, if the :association or :dependent option is given:
    record_activities :dependent => :destroy
    record_activities :association => :something_else    #this will use nullify, so your activities will not be cleaned up

Activity recording can be turned off by setting e.g. `Comment.record_userstamp` to false.

AUTHORS
=======
###Contributors
 - [rxcfc](http://in.finitu.de/)

###Author
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  