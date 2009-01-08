Problem
=======
 - Activity loggin should not invole the controller
 - Activity loggin should be dead-simple

Solution
========
 - Build activity loggin on top of userstamps plugin
 - Simple Activity(:action,:actor,:subject) stored to database

Setup
=====
 - Install and setup [userstamp](http://github.com/delynn/userstamp)
 - `script/plugin install git://github.com/grosser/record_activities.git`
 - Create an activities table for your database (see: MIGRATION)
 - Add `has_many :activities` to your user

Usage
=====

    class Comment < ActiveRecord::Base
      stampable
      record_activities #same as record_activities  :create, :update
    end
    User.first.activities.find(:all,:conditions=>{:action=>'create'})

    You may also use anything other than :create/:update/:save, but be sure to call the appropriate
    callback (model.record_activity_foo) when the action was performed.

TODO
====
 - Make it work with other models except User ?
 - Make userstamps into a gem and the add tests to this project...