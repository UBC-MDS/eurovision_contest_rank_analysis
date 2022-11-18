# Eurovision Rank Analysis

## Contributors

-   Mohammad Reza Nabizadeh

-   Crystal Geng

-   Renzo Winjgaarden

-   Daniel Cairns

Our data analysis project for DSCI 522 as part of the Master of Data Science program at the University of British Columbia.

## Introduction

Eurovision is an annual singing contest that takes place in Europe where each participating country is represented by a contestant performing a song of their choice, and the country which gains the highest number of votes in the final (which is ranked the highest) is elected to be the winner.

In this project, we are going to explore if there is any association between the running order and the rank of a contestant in Eurovision. Does the country that performs the last ranks higher than the country that performs the first? We are interested in this question because order can potentially have a large effect on the outcome of a competition. For instance, Glejser and Heyndels (2001) have shown that the contestants who perform later tend to gain a higher ranking from the jury in the Queen Elisabeth Contest. This question is crucial because it is related to the bias and fairness of competitions.

## Dataset 

The dataset we use in this project is retrieved from the [Tidy Tuesday Public Repository](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-05-17), and the original data was sourced from the [Eurovision Song Contenst Official Website](https://eurovision.tv/). The data was further cleaned up and scraped by Tanya Shapiro and Bob Rudis.

## Proposed Data Analysis

In order to answer the inferential question above, we are going to conduct various statistical analyses including two-sample t-test, pearson correlation coefficient analysis and linear regression. To carry out the t-test, we will first carry out a hypothesis testing, where the null hypothesis is that the mean rank is the same for the first ten countries that perform and the last ten countries that perform, and the alternative hypothesis is that the mean rank of the last ten countries that perform is higher (the rank index is smaller) than the first ten countries that perform.

Since the dataset contains the data for each country from 1956 to 2022, we are able to select the countries with the least ten running orders and the countries with the most ten running orders and calculate their respective mean ranks across all the years. The purpose of selecting only the top and last ten countries to perform every year, instead of dividing all the countries into two groups is to avoid ambiguity in classification. For instance, if there are 60 countries in total and they are divided into two separate groups called "countries that perform first" and "countries that perform last", the 30th country will be classified as "countries that perform first" and the 31st country will be classified as "countries that perform last", but in fact their running orders are both in the middle and it would not be a sensible choice to classify them differently.

We will also apply a pearson correlation coefficient analysis as well as a simple linear regression model to measure the linear correlation between the running order and the rank. For these analyses, we will not need to separate the countries into two groups according to their running orders since we are will treat their running orders as continuous variables.

## EDA

## Sharing the Results 

Our analysis will be conducted using Python in VS Code or Jupyter notebook where our tables and plots will be stored as outputs in the .ipynb notebook files. In order to render all the plots properly, we will also export a pdf version of all the .ipynb notebook files. For sharing purposes, all of our analyses and results will be pushed to our GitHub repository.

## Usage

The analysis can be reproduced by cloning the GitHub repository, installing the dependencies listed below and running the following commands at the terminal from the root directory of this project:

    Rscript pull_data.R --file_path="/data/raw/euro_vision.csv" --url="https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-17/eurovision.csv"

## Dependecies

Python 3.10.6 and packages:

-   docopt==0.7.1

-   ipython==7.10.1

-   vega_datasets==0.9.0

-   altair_saver==0.1.0

-   selenium==4.3.0

-   pandas==1.5.1

## License

The materials of this project are licensed under the MIT License. If re-using/re-mixing please provide attribution and link to this webpage.

## References

Glejser, Herbert, and Bruno Heyndels. "Efficiency and inefficiency in the ranking in competitions: The case of the Queen Elisabeth Music Contest." *Journal of cultural Economics* 25, no. 2 (2001): 109-129.
