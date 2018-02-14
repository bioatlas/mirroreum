# mirroreum

Stack for working with spatial data using R and RStudio Web / Shiny with assorted packages bundled (for example from ROpenSci)

## Quickstart

```bash
		docker run -d --name mywebide \
			--user $(id -u):$(id -g) \
			--publish 8787:8787 \
			--volume $(pwd):/home/rstudio \
			bioatlas/mirroreum
```

Visit `localhost:8787` in your browser and log in with username:password as `rstudio:rstudio`.

## Common configuration options:

Use a custom password by specifying the `PASSWORD` environmental variable:

		docker run -d -p 8787:8787 \
			-e PASSWORD=yourpasswordhere \
			bioatlas/mirroeum

Give the user root permissions (add to sudoers)

		docker run -d -p 8787:8787 \
			-e ROOT=TRUE \
			bioatlas/mirroeum

Link a local volume (in this example, the current working directory, `$(pwd)`) to the container:

		docker run -d -p 8787:8787 \
			-u $(id -u):$(id -g) \
			-v $(pwd):/home/rstudio \
			bioatlas/mirroeum

