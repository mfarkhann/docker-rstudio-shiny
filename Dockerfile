FROM rocker/verse
MAINTAINER "Farkhan Novianto" farkhan.novianto@gmail.com

## Install Shiny and cron from https://github.com/rocker-org/rocker-versioned/tree/master/rstudio
RUN export ADD=shiny && bash /etc/cont-init.d/add \
    && apt-get update && apt-get -y --no-install-recommends install cron \
    && mkdir -p /etc/services.d/cron \
    && echo '#!/bin/bash \
           \n exec cron -f -L 15' \
           > /etc/services.d/cron/run

# Install packages for supporting R packages
RUN apt-get -y --no-install-recommends install \
#     libgmp3-dev \
#     libicu-dev \
    libmpfr-dev \
#     libtcl8.5 \
#     libtk8.5 \
#     libv8-3.14-dev \
#     libudunits2-dev \
#     libproj-dev \
#     libgdal-dev \
#     tcl8.5-dev \
#     tk8.5-dev \
  && rm -rf /var/lib/apt/lists/*


## Install R Packages
RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    #--deps TRUE \
    # For Dashboard and Visualization
    shinydashboard rhandsontable shinyjs plotly dygraphs d3heatmap kohonen networkD3 ggvis flexdashboard shinyBS shinythemes colourpicker ggExtra ggmap ggplot2movies rpivotTable kableExtra sparkline billboarder shinycssloaders \ 
    # For Scheduler
    shinyFiles cronR here \
    # For API and Data pre Processing
    Rfacebook XLConnect googlesheets googleAnalyticsR sparklyr pool bcrypt instaR gtrendsR aws.s3 V8 js openxlsx maptools aws.ec2metadata \
    # For Analytics
    earth nloptr lavaan caroline forecast anomalyDetection BoomSpikeSlab mlogit tree e1071 HH lsa kappalab PerformanceAnalytics CausalImpact \
    # Remove temp file
    && rm -rf /*.gz /tmp/*.rds /tmp/*.gz /tmp/downloaded_packages/
    
RUN Rscript -e "devtools::install_github('tidyverse/googlesheets4')"
RUN Rscript -e "devtools::install_github('MarkEdmondson1234/googleID')"
RUN Rscript -e "devtools::install_github('sicarul/redshiftTools')"

    
## ~/ShinyApps for per User Setting and Copy Shiny Examples to Home Folder and Remove temp files
RUN yes | /opt/shiny-server/bin/deploy-example user-dirs \
    && mkdir /home/ShinyApps/ \
    && cp -R /usr/local/lib/R/site-library/shiny/examples/* /home/ShinyApps/ 

CMD ["/init"]