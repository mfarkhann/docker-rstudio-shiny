FROM rocker/verse:3.3.3
MAINTAINER "Farkhan Novianto" farkhan.novianto@gmail.com

## Install Shiny
# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get -y --no-install-recommends install \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
  && wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" \
  && VERSION=$(cat version.txt) \
  && wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb \
  && gdebi -n ss-latest.deb \
  && rm -f version.txt ss-latest.deb 

# Install packages for supporting R packages
RUN apt-get -y --no-install-recommends install \
    default-jdk \
    cron \
    libgmp3-dev \
    libv8-3.14-dev \
    supervisor \
  && rm -rf /var/lib/apt/lists/*

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
    earth sparklyr nloptr lavaan googlesheets caroline networkD3 Rfacebook forecast 

RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    --deps TRUE \
    anomalyDetection BoomSpikeSlab

# Install R Packages from Github
RUN R -e "devtools::install_github('google/CausalImpact')"
RUN R -e "devtools::install_github('rstudio/pool')"

# Setting Supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## ~/ShinyApps for per User Setting
RUN yes | /opt/shiny-server/bin/deploy-example user-dirs

# Copy Shiny Examples to Home Folder
RUN mkdir /home/ShinyApps/
RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /home/ShinyApps/

# Remove temp file
RUN rm -rf /*.gz /tmp/*.rds /tmp/*.gz /tmp/downloaded_packages/

# Expose Shiny Port - Rstudio Port 8787 have been exposed
EXPOSE 3838

CMD ["/usr/bin/supervisord"]
