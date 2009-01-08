Problem
=======
 - Activity loggin should not invole the controller

Solution
========
 - Build activity loggin on top of userstamps plugin

Install
=======
`script/plugin install git://github.com/grosser/record_activities.git`

Setup
=====
Install and setup [userstamp](http://github.com/delynn/userstamp)
Create an activities table in your database with `user_id` and string action.

Usage
=====

    class Comment < ActiveRecord::Base
      stampable
      record_activities #same as record_activities  :create, :update
    end

    Activity.find(:all,:conditions=>{:user_id=>12,:action=>'create')
    or user has_many :activities in your user.rb