FROM rocker/verse
MAINTAINER "Farkhan Novianto" farkhan.novianto@gmail.com

## Install Shiny
# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get -y --no-install-recommends install \
    default-jdk \
    cron \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libv8-3.14-dev \
  && wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" \
  && VERSION=$(cat version.txt) \
  && wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb \
  && gdebi -n ss-latest.deb \
  && rm -f version.txt ss-latest.deb \
  && rm -rf /var/lib/apt/lists/*

## ~/ShinyApps
RUN yes | /opt/shiny-server/bin/deploy-example user-dirs

## Install R Packages
# Install R Packages for Shiny Dashboard
RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    --deps TRUE \
    shinydashboard rhandsontable shinyjs DT plotly dygraphs d3heatmap kohonen

# Install R Packages For Scheduller
RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    --deps TRUE \
    shinyFiles cronR

# Install Aditional R Packages
RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    --deps TRUE \
    earth sparklyr nloptr lavaan googlesheets caroline networkD3 Rfacebook forecast BoomSpikeSlab AnomalyDetection 

# Install R Packages from Github
RUN R -e "devtools::install_github('google/CausalImpact')"
RUN R -e "devtools::install_github("rstudio/pool")"


EXPOSE 3838 8787

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
