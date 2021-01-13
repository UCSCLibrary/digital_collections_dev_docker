#!/usr/bin/env bash
/srv/wait-for-services.sh localhost:3000 -t 600
/srv/wait-for-services.sh db:3306 -t 180
/srv/wait-for-services.sh repo:8080 -t 180
/srv/wait-for-services.sh index:8983 -t 180
CI=true bundle exec rspec /srv/hycruz/spec/unit /srv/hycruz/spec/integration
