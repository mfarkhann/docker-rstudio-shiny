# docker-rstudio-shiny
Docker for Rstudio and Shiny Server in one Container

## Usage:
Using tag 3.3.3 (R Version 3.3.3)
To Build :
On this directory Run 
```sh
docker build . -t farkhan/shiny:3.3.3
```


To run a temporary container with Shiny Server:

```sh
docker run --rm -it -p 3838:3838 -p 8787:8787 -e USER=rstudio -e PASSWORD=pass  farkhan/rstudio-shiny:3.3.3 
```


In Production
```sh
docker run --name rstudio-shiny -d -p 127.0.0.1:80:3838 -p 127.0.0.1:8787:8787 -e USER=rstudio -e PASSWORD=pass  farkhan/rstudio-shiny:3.3.3 
```