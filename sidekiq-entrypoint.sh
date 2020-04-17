#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

# Uncomment this line to load environment and then
# do nothing, so we can ssh in and change things
#sleep infinity

# Wait for Redis

echo "Retrieving latest code"
git pull

echo "updating gemset"
gem install bundler
bundle install
gem install bundler

echo "Stopping Existing sidekiq Tasks"
ps aux |grep -i [s]idekiq | awk '{print $2}' | xargs kill -9 || true

echo "Starting Sidekiq"

mkdir /srv/hycruz/log
touch /srv/hycruz/log/sidekiq.log
bundle exec sidekiq -c 1 -L /srv/hycruz/log/sidekiq.log  >> /srv/hycruz/log/sidekiq.log 2>&1


