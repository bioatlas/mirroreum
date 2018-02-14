FROM rocker/ropensci:latest

#RUN rm -vfr /var/lib/apt/lists/*

#RUN apt-get update && apt-get -y upgrade && apt-get install -y \
#	texlive-generic-recommended texlive-xetex \
#	libmpfr-dev \
#	cimg-dev \
#	libhdf4-dev hdf4-tools \
#	libnetcdf-dev netcdf-bin \
#	proj-bin libproj-dev gdal-bin \
#	libgdal-dev \
#    libnlopt-dev

# for knitting pdfs etc with Tufte styles
#RUN kpsewhich -var-value TEXMFLOCAL

# explicitly install R pkg deps for HieRanFor and UpScaling
# since the --deps TRUE option doesn't seem to work below (?)
RUN install2.r --error \
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
	move

# add packages for zoa
RUN wget -P /tmp 'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/kftrack_0.70-x64.tar.gz' && \
	wget -P /tmp 'https://rawgit.com/positioning/kalmanfilter/master/downloads/R3x/64bit/linux/ukfsst_0.3-x64.tar.gz' && \
	Rscript -e "install.packages('/tmp/kftrack_0.70-x64.tar.gz', repos=NULL)" && \
	Rscript -e "install.packages(c('date', 'ncdf'), repos='http://cran.csiro.au/')" && \
	Rscript -e "install.packages('/tmp/ukfsst_0.3-x64.tar.gz', repos=NULL)"

# add semi-packaged eubon R packages
# RUN mkdir -p /tmp/eubon
# WORKDIR /tmp/eubon
# ADD ./*.R /tmp/eubon/
# ADD ./*.zip /tmp/eubon/
# RUN unzip HieRanFor*.zip
# RUN unzip UpScaling*.zip

# can RForge be used instead?
# RUN cd /tmp/eubon && install2.r --deps TRUE --repos NULL --error \
#	HieRanFor \
#	UpScaling

# add GitHub and Ecology packages
RUN installGithub.r --deps TRUE \
	raquamaps/raquamaps \
	mskyttner/swedishbirdtrends \
	mskyttner/swedishbirdrecoveries \
	AtlasOfLivingAustralia/ALA4R \
	azizka/sampbias \
	azizka/speciesgeocodeR \
	fschirr/VirSysMon

# clean up
RUN rm -rf /tmp/*.rds && \
	apt-get autoclean

WORKDIR /home/rstudio
EXPOSE 8787
