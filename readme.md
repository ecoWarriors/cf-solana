# CF Solana API

This is the development repo for [Solana API](https://docs.solana.com/developing/clients/jsonrpc-api) integrated with [Adobe ColdFusion](https://coldfusion.adobe.com/).

## Running Locally

### Prerequisites

1. [Docker](https://www.docker.com/) or other container virtualization software. We also suggest [Podman](https://github.com/containers/podman) and [podman-compose](https://github.com/containers/podman-compose) as an alternative to Docker.
2. [Postman](https://www.postman.com/) - We will use this to test the API's. Download and import our specific [CF Solana Snapshot](https://www.getpostman.com/collections/393462fe546943d1a8c0).
3. A Solana account is needed to call the Solana API. Download a Solana wallet such as [Phantom](https://phantom.app/download) to create a new account and receive a wallet address.

### Getting Started

1. Clone this repository to your computer.
2. Copy `.env.dev` to `.env`.  No changes are necessary at this time.
3. Make sure docker or other container software is running.
4. Run `docker-compose -f docker-compose.dev.yml up -d`
5. Open a web browser to `localhost:8080`
6. Follow through the ContentBox wizard to setup the first user of the CMS.

**NOTE**:

To support Apple M1 chips, we are adding `platform: linux/amd64` to the docker compose for each service.

## Troubleshooting

**Question**: How do I do local development?

**Answer**: We are mounting the necessary files needed for development in to the docker container via volume mount points.  All of the customizable files for the installation are included in the `/modules_app/contentbox-custom/` folder of this repository.  After editing any of these files, you will need to reload the application using the command line command `coldbox reinit` or via the web browser by appending `/?fwreinit=contentbox` to the url.

**Question**: Where are the database and container environment variable configurations?

**Answer**: The MySQL environment variables are set in the `.env` and are then used in the `docker-compose.yml` file to be passed in to the docker containers for initialization.  The database files themselves are stored in the `./db/mysql8/data` folder which is NOT committed to the repository.  Each time you restart your docker environment, any files in this folder will be loaded into the database so that you can pick up where you left off.

**Question**: How do I manually restart the ColdBox server from within the docker container?

**Answer**: From the command line, while in the project root folder, run `box` to initialize the ColdBox REPL. Then, once it is loaded you should see the commandbox ASCII art welcome message. Run `server stop` to stop the server. You can verify what the status of the server is by running `server list`. Then, to restart the server run `server start openbrowser=false verbose=true`.

**Question**: How do I enter a docker container from the command line?

**Answer**: First will need to list out all the running docker containers with `docker ps`. Find the container that want to enter and look for the name under the `NAMES` column. Then, run `docker exec -it <container_name> /bin/bash`. You will be moved into the docker container and can run commands from that system.

**Question**: How do I send emails through SMTP on development server?

**Answer**: when running ContentBox in development mode, emails are never sent via SMTP.  They are always logged to the file system. You can find the email logs in the ContentBox installation folder under `/config/logs/mail/`. When run in production mode, the admin SMTP settings are honored and if not specified, they default back to the CF Admin mail settings.

**Question**: How do I send emails through SMTP on staging or production?

**Answer**: Yes, in production mode ContentBox will send via SMTP and can use any SMTP server that is reachable (i.e. network security, etc.)

**Question**: I am getting a message about aardvark-dns not being available. What is this?

**Answer**: aardvark-dns is Podman's new container DNS resolver; it is used to communicate with containers on the same network. Consequently, you will need to install it on the host machine with your operating system's package manager.

**Question**: I am getting a database connection issue with Podman the first time I start the containers.

**Answer**: This is a known problem that I have been encountering also; I think it is a startup lag where things are still coming up. Simply waiting it out and refreshing the page from time to time fixes this. If there is a real problem and it does not come up, please do follow an issue. This problem also manifests itself with a browser message like "connection was reset" or some similar verbiage.

**Question**: How can I cleanup local Docker instances running?

**Answer**:

```bash
docker stop $(docker ps -aq)
docker system prune --all --force
docker volume rm $(docker volume ls -q)
```
This will stop all containers and remove the volumes.
