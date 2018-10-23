# mirroreum

The `mirroreum` is an AGPL-licensed portable dockerized software stack supporting reproducible research efforts within biodiversity informatics. At the base is a Debian OS with system libraries for geospatial work pre-installed. On top of this comes various software to support working with R and Python and for using pandoc. It can be used entirely through the web browser and/or at the CLI and it can run locally or deployed at a server in the cloud.

To support work using R, it provides a platform for working with spatial data using R and the web-variant of the RStudio IDE as well as a Shiny server. This means it comes with a pre-installed set of various assorted packages (for example from ROpenSci packages, Shiny etc etc). It extends the [rocker-org/ropensci](https://github.com/rocker-org/ropensci) image with additional packages (see the Dockerfile for details). Among the many pre-installed packages is ALA4R and livingatlases - R packages which provides access to data sources in the Living Atlases community. Various other packages are pre-installed to support for example ecological niche modelling work.

For more documentation and usage instructions, please see the [wiki](https://github.com/rocker-org/rocker/wiki) and this [excellent tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)

## Quickstart

If you have an account at a server deployment such as https://mirroreum.bioatlas.se you could log in there to get started.

If you are a developer or system adminsitrator, you might be interested in downloading and running `mirroreum` locally, which requires that you have Docker installed.

Then, to start `mirroreum` locally, link a local volume (in this example, the current working directory, `$(pwd)`) to the container, start it and point your browser to it with these CLI commands:

```bash
docker run -d --name mywebide \
	--env USERID=$UID \
	--publish 8787:8787 \
	--volume $(pwd):/home/rstudio \
	bioatlas/mirroreum

# use login rstudio:rstudio
firefox http://localhost:8787 &

```

The first command will start the container in the background so you can visit `http://localhost:8787` with your web browser and log in with username:password as `rstudio:rstudio`.

You can also then run the CLI if you wish with:

```bash
docker exec -it mywebide bash

```

You can list the full set of included packages with:

```bash
docker exec -it mywebide \
	R --quiet -e "cat(rownames(installed.packages()))"

```

## Common configuration options:

Use a custom user named after your user on the host, and password specified in the `PASSWORD` environmental variable, and give the user root permissions (add to sudoers) and work on files in the ~/foo working directory:

```bash
docker run -d --name mywebide \
	-p 8787:8787 \
	-e ROOT=TRUE \
	-e USERID=$UID \
	-e USER=$USER \
	-e PASSWORD=yourpasswordhere \
	-v $(pwd)/foo:/home/$USER/foo \
	-w /home/$USER/foo \
	bioatlas/mirroeum

```

### Using Shiny

To use the image as a Shiny server, you can override the startup command to use `/usr/bin/shiny-server.sh`:

```bash
docker run -d --name myshinyapp \
	-p 3838:3838 \
    bioatlas/mirroreum /usr/bin/shiny-server.sh

firefox http://localhost:3838 &

``` 

This will launch the default Shiny app in the container (see the Dockerfile for deployment details).

To deploy your own app you can expose a directory on the host with your app to the container. For mapping the host directory use the option `-v <host_dir>:<container_dir>`. The following command will use the present working directory as the Shiny app directory.

```bash
docker run -d --name myshinyapp \
	-p 3838:3838 \
    -v $(pwd)/:/srv/shiny-server/ \
    bioatlas/mirroreum /usr/bin/shiny-server.sh

```

If you have a Shiny app in a subdirectory of your present working directory named appdir, you can now use a web browser to access the app by visiting http://localhost:3838/appdir/


