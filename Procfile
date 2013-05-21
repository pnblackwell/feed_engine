web: bundle exec rails server puma -p $PORT
worker: QUEUE=* bundle exec rake resque:work
scheduler: bundle exec rake resque:scheduler
