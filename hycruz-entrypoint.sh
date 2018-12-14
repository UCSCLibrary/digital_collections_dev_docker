#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

max_try=${WAIT_MAX_TRY:-12}
wait_seconds=${WAIT_SECONDS:-5}

if [ -f /opt/hyrax/tmp/pids/server.pid ]; then
  echo "Stopping Rails Server and Removing PID File"
  ps aux |grep -i [r]ails | awk '{print $2}' | xargs kill -9
  rm -rf /opt/hyrax/tmp/pids/server.pid
fi

echo "Checking and Installing Ruby Gems"
bundle check || bundle install

echo "Running Database Migration"
bundle exec rake db:migrate db:seed

echo "Load Workflows"
bundle exec rake hyrax:workflow:load

#echo "Initialize Default Admin Set"
bundle exec rake hyrax:default_admin_set:create

echo "Starting the Rails Server"
exec bundle exec rails s -b 0.0.0.0
