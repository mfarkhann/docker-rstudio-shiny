FROM rocker/verse:3.6.0
MAINTAINER "Farkhan Novianto" farkhan.novianto@gmail.com

## Install Shiny and cron from https://github.com/rocker-org/rocker-versioned/tree/master/rstudio
RUN export ADD=shiny && bash /etc/cont-init.d/add \
    && apt-get update 

# Install packages for supporting R packages
RUN apt-get -y --no-install-recommends install \
    libmpfr-dev \
  && rm -rf /var/lib/apt/lists/*


## Install R Packages
RUN  . /etc/environment \
    && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    #--deps TRUE \
    Boom 
    # For Dashboard and Visualization
    shinydashboard rhandsontable shinyjs plotly dygraphs d3heatmap kohonen networkD3 ggvis flexdashboard shinyBS shinythemes colourpicker ggExtra ggmap ggplot2movies rpivotTable kableExtra sparkline billboarder shinycssloaders \ 
    # For Scheduler
    shinyFiles cronR here \
    # For API and Data pre Processing
    Rfacebook XLConnect googlesheets googleAnalyticsR sparklyr pool bcrypt instaR gtrendsR aws.s3 V8 js openxlsx maptools aws.ec2metadata redshiftTools \
    # For Analytics
    earth nloptr lavaan caroline forecast BoomSpikeSlab mlogit tree e1071 HH lsa kappalab PerformanceAnalytics CausalImpact \
    # Remove temp file
    && rm -rf /*.gz /tmp/*.rds /tmp/*.gz /tmp/downloaded_packages/
        
## ~/ShinyApps for per User Setting and Copy Shiny Examples to Home Folder and Remove temp files
RUN yes | /opt/shiny-server/bin/deploy-example user-dirs \
    && mkdir /home/ShinyApps/ \
    && cp -R /usr/local/lib/R/site-library/shiny/examples/* /home/ShinyApps/ 

# Set Indonesia Locale    
RUN sed -i -e 's/# id_ID.UTF-8 UTF-8/id_ID.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

CMD ["/init"]