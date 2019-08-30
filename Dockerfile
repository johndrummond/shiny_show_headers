FROM rocker/tidyverse

#install other packages
RUN install2.r  shiny


# add user and make sure her stuff is writable 
# whichever userid is given at runtime
RUN adduser --disabled-password --gid 0 --gecos "SHINY user" shiny
USER shiny
RUN chown shiny:root /home/shiny && chmod -R 0775 /home/shiny
ENV HOME /home/shiny

RUN mkdir -m 0775 /home/shiny/R
RUN mkdir -m 0775 /home/shiny/logs
RUN mkdir -m 0775 /home/shiny/bookmark
COPY  R/ /home/shiny/R/


EXPOSE 8099


# run the server
CMD ["R", "-e", "shiny::runApp('/home/shiny/R/', port=8099,host='0.0.0.0')"]

