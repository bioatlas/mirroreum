#! make

all: latest 0.9.0 0.9.1

latest: 
	docker build -t bioatlas/mirroreum .

0.9.0: 
	docker build -t bioatlas/mirroreum:0.9.0 0.9.0

0.9.1: 
	docker build -t bioatlas/mirroreum:0.9.1 0.9.1

release:
	docker push bioatlas/mirroreum
	docker push bioatlas/mirroreum:0.9.0
	docker push bioatlas/mirroreum:0.9.1

.PHONY: all latest 0.9.0 0.9.1 release

