#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

# Wait for Redis

echo "Checking and Installing Ruby Gems"
bundle check || bundle install

echo "Stopping Existing sidekiq Tasks"
ps aux |grep -i [s]idekiq | awk '{print $2}' | xargs kill -9 || true

echo "Starting Sidekiq"
exec bundle exec sidekiq -c 1

exec "$@"
