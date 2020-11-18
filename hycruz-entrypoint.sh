#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

max_try=${WAIT_MAX_TRY:-12}
wait_seconds=${WAIT_SECONDS:-5}

if [ -f /srv/hycruz/tmp/pids/server.pid ]; then
  echo "Stopping Rails Server and Removing PID File"
#  ps aux |grep -i [r]ails | awk '{print $2}' | xargs kill -9
  rm -rf /srv/hycruz/tmp/pids/server.pid
fi

echo "Retrieving latest code"
git checkout -- Gemfile.lock
git pull

echo "updating gemset"
gem install bundler
bundle install
gem install bundler

echo 'alias repl="cd /srv/hycruz; bundle exec rails c"' >> /home/hycruz/.bashrc
echo 'alias errors="tail -n 1000 /srv/hyrax/logs/development.log | grep FATAL -A 20 -B 20"' >> /home/hycruz/.bashrc

# Uncomment this line to ssh into the container before loading the app
#sleep infinity

#echo "Starting the Rails Server"
bundle exec rails s -b 0.0.0.0

#echo "Running local tests"
#bundle exec rspec spec/local

#echo "Running remote tests"
#bundle exec rspec spec/remote
