#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require File.expand_path('../config/application', __FILE__)

FeedEngine::Application.load_tasks

require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  Resque.redis = ENV['REDISTOGO_URL'] || "redis://localhost:6379"
  ENV["QUEUE"] ||= "*"
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  Resque.schedule = {"FetchingScheduler"=>{"cron"=>"* * * * *", "class" => "FetchingScheduler", "queue"=> "schedule"}}
end

task "resque:scheduler_setup" => :environment

task "jobs:work" => "resque:work"
