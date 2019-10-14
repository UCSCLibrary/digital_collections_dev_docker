This repository contains docker files and auxiliary packages necessary to set up and run a development environment for UCSC's DAMS. We have set up this docker environment purely to create a flexible platform independent development solution; this docker setup is not currently used for deployment or for any production environments.

### Prerequisites
- Docker

## Setting up your development environment
### Clone repositories and set up directory structure
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
```


### Initialize relational database
First, try starting up the docker stack and ignore any errors from the Solr (index), Hyrax (webapp), and Sidekiq (worker) containers.
```
cd ${HYCRUZ_HOME}
docker-compose up
```
Ignoring the stream of error and status messages, open a new terminal and enter the following to log into the MySql (Db) container and initialize the mysql installation there. Follow the prompts to customize the root password and such. You can accept most of the defaults here.
```
docker exec -it mysql bash
> mysql -u root
> sudo mysql_secure_installation
```
Now log in to MySql with `mysql -u root -p{PASSWORD CREATED IN LAST STEP}` and create a new database and a new user with full access privileges to that database. Keep track of the username, password, and database name which you will use in the next step.
```
CREATE DATABASE 'hycruz';
CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'dev_pass';
GRANT ALL PRIVILEGES ON hycruz.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES
```
That should do it for the relational database. Log out and you're all set.

### Edit private configuration files
Certain configuration files contain sensitive information and are therefore omitted from the public github repositories. You will need to create these configuration files manually. Please contact our developers for assistance if you have issues with this.
These files include:
- /config/database.yml
- /config/secrets.yml
- /config/fedora.yml
- /config/github.yml

### Create Solr core
The Solr part of this docker environment does not come pre-configured for our indexing needs (we could improve this repository in the future by setting that up). Currently some on-time configuration work is necessary to get Solr started for the first time on a development instance. Vague instructions for this step are provided for now as a placeholder pending the creation of a more thorough walkthrough.
First, log in to the solr container using `docker exec -it solr bash`. Create the directory structure you need with:
```
mkdir /opt/solr/server/solr/hycruz
mkdir /opt/solr/server/solr/hycruz/data
```
Next you need to get our solr configuration files onto the solr container. Log out of the solr container and use the following command:
```
docker cp ${HYCRUZ_PATH}/docker/solr-conf/. mysql:/opt/solr/server/solr/hycruz/config
```
Finally you can create the actual core in solr. In your browser, navigate to http://localhost/solr/~cores and click "Add Core". Enter the following information:
```
name: Hycruz
instance_dir: /opt/solr/server/solr/hycruz
data_dir: /opt/solr/server/solr/hycruz/data
config: /opt/solr/server/solr/hycruz/config/solrconfig.xml
schema: /opt/solr/server/solr/hycruz/config/schema.xml
```
Click 'Add Core' and make sure it creates the core successfully.

## Restart Docker and check for errors
In the original docker terminal, press ctrl-C to stop the docker process. Then enter `docker-compose down; docker-compose up` to completely restart the docker stack. Hopefully everything will come online succesfully. Navigate to http://localhost to view the site if it works.

## Log in to a repl on the dev site
If you need a repl on the dev site, first log in to the webapp container: `docker exec -it hycruz`. Then you can just enter `repl` to activate a shortcut I created to set the bundle parameters correctly and start the repl. 
