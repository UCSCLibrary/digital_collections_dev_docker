#!/usr/bin/env bash
/srv/hycruz/wait-for-services.sh localhost:3000 -t
/srv/hycruz/wait-for-services.sh db:3306 -t 180
/srv/hycruz/wait-for-services.sh repo:8080 -t 180
/srv/hycruz/wait-for-services.sh index:8983 -t 180
bundle exec rspec /srv/hycruz/spec/unit
