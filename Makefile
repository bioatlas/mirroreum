#! make

all: latest 0.9.0

latest: 
	docker build -t bioatlas/mirroreum .

0.9.0: 
	docker build -t bioatlas/mirroeum:0.9.0 0.9.0


.PHONY: all latest 0.9.0

echo "building bioatlas/mirroeum image(s)..."

