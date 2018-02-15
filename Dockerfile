FROM rocker/ropensci:3.4.1

RUN rm -vfr /var/lib/apt/lists/*

COPY ./sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y -no-install-recommends \
	proj-bin \
	gdal-bin \
	libhdf4-dev \
	netcdf-bin \
	libnlopt-dev \
&& install2.r --error \
	sparklyr \
	downscale \
	getopt \
	tufte \
	tufterhandout \
	ggmap \
	rticles \
	tint \
	cartogram \
	randomForest \
	Rserve \
	caret \
	treemap \
	AICcmodavg \
	SDMTools \
	ade4 \
	adehabitatHR \
	adehabitatMA \
	maptools \
	shapefiles \
	alphahull \
	spatstat \
	Grid2Polygons \
	googleVis \
	spacetime \
	plotKML \
	pdfCluster \
	move \
	maxnet \
	red

# add packages for zoa
RUN wget -P /tmp 'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/kftrack_0.70-x64.tar.gz' && \
	wget -P /tmp 'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/ukfsst_0.3-x64.tar.gz' && \
	Rscript -e "install.packages('/tmp/kftrack_0.70-x64.tar.gz', repos=NULL)" && \
	Rscript -e "install.packages(c('date', 'ncdf'), repos='http://cran.csiro.au/')" && \
	Rscript -e "install.packages('/tmp/ukfsst_0.3-x64.tar.gz', repos=NULL)"

# add GitHub and Ecology packages
RUN installGithub.r --deps TRUE \
	AtlasOfLivingAustralia/ALA4R \
	azizka/sampbias \
	azizka/speciesgeocodeR \
	raquamaps/raquamaps \
	mskyttner/swedishbirdtrends \
	mskyttner/swedishbirdrecoveries \
	fschirr/VirSysMon

# clean up
RUN rm -rf /tmp/*.rds && \
	apt-get autoclean
