Play is simple utility docker container for the devops guys

build

```
docker build -t narenp/play:latest .
docker push narenp/play:latest
docker run -it -v ${pwd}:/work -w /work -p 5000:5000 narenp/play:latest /bin/sh

```