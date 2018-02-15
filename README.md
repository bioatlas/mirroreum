# mirroreum

The `mirroreum`is a stack for working with spatial data using R and RStudio Web which includes various assorted packages (for example from ROpenSci packages, Shiny etc etc). It extends the [rocker-org/ropensci](https://github.com/rocker-org/ropensci) image with additional packages (see the Dockerfile for details).

For more documentation and usage instructions, please see the [wiki](https://github.com/rocker-org/rocker/wiki) and this [excellent tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)

## Quickstart

Link a local volume (in this example, the current working directory, `$(pwd)`) to the container:

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

You can list the full set of included packages from the CLI with:

```bash
docker exec -it mywebide \
	R --quiet -e "cat(rownames(installed.packages()))"

```

## Common configuration options:

Use a custom user named after your user on the host, and password specified in the `PASSWORD` environmental variable, and give the user root permissions (add to sudoers) and work on files in the ~/foo working directory:

```bash
docker run -d -p 8787:8787 \
	-e ROOT=TRUE \
	-e USERID=$UID \
	-e USER=$USER \
	-e PASSWORD=yourpasswordhere \
	-v $(pwd)/foo:/home/$USER/foo \
	-w /home/$USER/foo \
	bioatlas/mirroeum

```

