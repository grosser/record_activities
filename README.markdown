Problem
=======
 - Activity logging should not involve the controller
 - Activity logging should be dead-simple

Solution
========
 - Build activity logging on top of [userstamps](http://github.com/delynn/userstamp) plugin
 - Simple Activity(:action, :actor, :subject) stored to database

Setup
=====
 - Install and setup [userstamps](http://github.com/delynn/userstamp)
 - `script/plugin install git://github.com/grosser/record_activities.git`
 - Create an activities table for your database (see: MIGRATION)
 - (Optional) Add `has_many :activities, :dependent => :destroy, :foreign_key => :actor_id` to your user

Usage
=====

    class Comment < ActiveRecord::Base
      stampable
      record_activities :dependent => :destroy
    end
    Comment.create! --> Activity(:subject => comment, :actor => current_user, :action => 'create')

`record_activities` is the same as `record_activities :create, :update`.  
You may also use anything other than the supported `:create / :update / :save`, but be sure to call the appropriate  
callback `model.record_activity_foo` when the action `foo` was performed.

A Comment `has_many :activities`, if the :association or :dependent option is given:
    record_activities :dependent => :destroy
    record_activities :association => :something_else    #this will use nullify, so your activities will not be cleaned up

Activity recording can be turned off by setting e.g. `Comment.record_userstamp` to false.

TODO
====
 - Make it work with other models except User ?

AUTHOR
======
Michael Grosser  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  