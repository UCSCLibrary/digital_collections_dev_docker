This repository contains docker files and auxiliary packages necessary to set up and run a development environment for UCSC's DAMS. We have set up this docker environment purely to create a flexible platform independent development solution; this docker setup is not currently used for deployment or for any production environments.

### Prerequisites
- Docker

## Setting up your development environment
### Clone repositories and set up directory structure
```bash
git clone git@github.com:UCSCLibrary/ucsc-library-digital-collections.git hyrax
git clone git@github.com:UCSCLibrary/digital_collections_dev_docker.git docker
git clone git@github.com:UCSCLibrary/bulkops.git bulk_ops
git clone git@github.com:UCSCLibrary/scoobysnacks.git scooby_snacks
git clone git@github.com:UCSCLibrary/samvera_hls.git samvera_hls
mkdir dams_ingest
mkdir dams_derivatives
cd docker
```

### Edit private configuration files
All configuration is done in .env.development.  Currently defaults can be found in .env, but items in .env.development can be used to override these values.


## Start Docker and check for errors
In the original docker terminal, enter `docker-compose up` to completely start the docker stack. Hopefully everything will come online succesfully. Navigate to http://localhost:3000 to view the site if it works.

## Log in to a repl on the dev site
If you need a repl on the dev site, first log in to the webapp container: `docker exec -it hycruz bash`. Then you can just enter `repl` to activate a shortcut I created to set the bundle parameters correctly and start the repl. 
