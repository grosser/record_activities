Problem
=======
 - Activity loggin should not involve the controller
 - Activity loggin should be dead-simple

Solution
========
 - Build activity loggin on top of [userstamps](http://github.com/delynn/userstamp) plugin
 - Simple Activity(:action,:actor,:subject) stored to database

Setup
=====
 - Install and setup [userstamps](http://github.com/delynn/userstamp)
 - `script/plugin install git://github.com/grosser/record_activities.git`
 - Create an activities table for your database (see: MIGRATION)
 - Add `has_many :activities, :dependent=>:destroy, :foreign_key => :actor_id` to your user

Usage
=====

    class Comment < ActiveRecord::Base
      stampable
      record_activities #same as record_activities  :create, :update
    end
    Comment.create! --> Activity(:subject=>comment,:actor=>current_user,:action=>'create')

    You may also use anything other than :create/:update/:save, but be sure to call the appropriate
    callback (model.record_activity_foo) when the action was performed.

TODO
====
 - Make it work with other models except User ?
 - Make userstamps into a gem and the add tests to this project...

AUTHOR
======
Michael Grosser  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...  