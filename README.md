This repository contains docker files and auxiliary packages necessary to set up and run a development environment for UCSC's DAMS. We have set up this docker environment purely to create a flexible platform independent development solution; this docker setup is not currently used for deployment or for any production environments.

# Setting up a development environment for UCSC's Samvera based DAMS

```bash
HYCRUZ_HOME= "/srv"
git clone git@github.com:UCSCLibrary/ucsc-library-digital-collections.git ${HYCRUZ_HOME}/hycruz
git clone git@github.com:UCSCLibrary/digital_collections_dev_docker.git ${HYCRUZ_HOME}/docker
git clone git@github.com:UCSCLibrary/bulk_ops.git ${HYCRUZ_HOME}/bulk_ops
git clone git@github.com:UCSCLibrary/scooby_snacks.git ${HYCRUZ_HOME}/scooby_snacks
git clone git@github.com:UCSCLibrary/samvera_hls.git ${HYCRUZ_HOME}/samvera_hls
mkdir ${HYCRUZ_HOME}/dams_ingest
mkdir ${HYCRUZ_HOME}/dams_derivatives
cd ${HYCRUZ_HOME}/docker
docker-compose up
```
