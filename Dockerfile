# Docker file for the Eurovision Ranking Analysis
# Crystal Geng, Renzo Wijngaarden, Mohammad Reza Nabizadeh, Daniel Cairns, Dec 2022

# Use jupyter/scipy-notebook as the base image and update conda
FROM continuumio/miniconda3
RUN conda update -n base -c conda-forge -y conda


# Install base R
RUN apt-get update
RUN apt-get -y --no-install-recommends install
RUN apt-get install r-base r-base-dev -y
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get install libssl-dev -y
RUN apt-get install libxml2-dev libcurl4-openssl-dev libssl-dev libfontconfig1-dev -y



# Install R Packages
RUN Rscript -e "install.packages('tidyverse', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('broom', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('docopt', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('pandoc', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('knitr', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('kableExtra', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('caret', repos='https://cran.rstudio.com/')"
RUN Rscript -e "install.packages('xfun', repos='https://cran.rstudio.com/')"
RUN conda install -c conda-forge -y lxml
RUN conda install -c conda-forge -y pandoc


# install python packages 
RUN conda install -y -c anaconda \ 
    docopt \
    requests \
    ipykernel \
    ipython \
    selenium \
    pandas \
    pip

# Run pip installer
RUN pip install altair
RUN pip install vl-convert-python
RUN pip install docopt-ng

# Install Chromium
RUN apt-get update && \
    apt install -y chromium && \
    apt-get install -y libnss3 && \
    apt-get install unzip

# Install Chromedriver
RUN wget -q "https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip" -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip -d /usr/bin/ && \
    rm /tmp/chromedriver.zip && chown root:root /usr/bin/chromedriver && chmod +x /usr/bin/chromedriver


# Put Anaconda Python in PATH
ENV PATH="/opt/conda/bin:${PATH}"
CMD ["/bin/bash"]
