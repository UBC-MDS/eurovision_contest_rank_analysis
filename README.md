# Eurovision Rank Analysis

## Contributors

- Mohammad Reza Nabizadeh

- Crystal Geng

- Renzo Wijngaarden

- Daniel Cairns

Our data analysis project for DSCI 522 as part of the Master of Data Science program at the University of British Columbia.

## Introduction

Eurovision is an annual singing contest that takes place in Europe where each participating country is represented by a contestant performing a song of their choice, and the country which gains the highest number of votes in the final (which is ranked the highest) is elected to be the winner.

In this project, we are going to explore if there is any association between the running order and the rank of a contestant in Eurovision. Does the country that performs the last rank higher than the country that performs the first? We are interested in this question because order can potentially have a large effect on the outcome of a competition. For instance, Glejser and Heyndels (2001) have shown that the contestants who perform later tend to gain a higher rank from the jury in the Queen Elisabeth Contest. This question is crucial because it is related to the bias in voting and fairness of competitions.

## Dataset

The dataset we use in this project is retrieved from the [Tidy Tuesday Public Repository](https://github.com/rfordatascience/tidytuesday/tree/master/data/2022/2022-05-17), and the original data was sourced from the [Eurovision Song Contenst Official Website](https://eurovision.tv/). The data was further cleaned up and scraped by Tanya Shapiro and Bob Rudis and contributed to the Tidy Tuesday Repository.

## EDA

In our exploratory data analysis, we will include the following figures:

-   A pair-wise correlation of all the numeric columns in the data set.
-   A heatmap of missing values for each column in the dataset.

## Proposed Data Analysis

From our EDA we determined, by looking at the correlation plot for running order and resulting rank, that there didn't appear to be a strong correlation between these two variables.

In order to answer the inferential question above, we are looking to conduct various t-tests. To carry out the t-test, we will first carry out the following two hypothesis tests:

Firstly, the null hypothesis is defined such that the mean rank of countries not performing first is the same as countries performing first, and the alternative hypothesis is that the mean rank of countries not performing first is different from the mean rank of countries performing first.

Next, we look at the last performance of the night. We define the null hypothesis such that the mean rank of countries not performing last is the same as countries performing last, and the alternative hypothesis is that the mean rank of countries not performing last is different from the mean rank of countries performing last.

Since the dataset contains the results for both the semi-finals and the grand-finals, we next look to see if there's a difference between these shows. We separate results from these categories, and carry out the same hypothesis tests.

## Sharing the Results

Our analysis will be conducted using Python and R scripts, where any created tables and plots will be stored in relevant directories. The report will use the outputs of these scripts to visualise and convey our findings. In order to render all the plots properly, we will also export a PDF version of this report. For sharing purposes, all of our analyses and results will be pushed to our GitHub repository.

## Usage

The analysis can be reproduced by cloning the GitHub repository, installing the dependencies listed below and running the following commands at the terminal from the root directory of this project: 
### Option1: Running the analysis step-by-step by using commands
After cloning the repository, navigate to the repository's root folder in CLI and run the steps below:

1. Download the data by running `src/pull_data.R`: \
`--file_path` should be the path where the data will be saved, \
`--url` should be the link to the data. \
`Rscript src/pull_data.R --file_path="data/raw/eurovision.csv" --url="https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-17/eurovision.csv"`

2. Create the exploratory analysis plots and save them by running `src/eurovision_eda.py`: \
`--input_file` should be the file address the raw data, \
`--output_dir` should be the path to the directory where the plots will be saved. \
`python src/eurovision_eda.py --input_file="data/raw/eurovision.csv" --output_dir="src/eda_data/figures"`

3. Pre-process the data by running `src/eurovision_eda.py`: \
`--input_file` should be the file path to the data being pre-processed, \
`--output_path` the file path to where the pre-processed data will be saved. \
`python src/eurovision_preprocessing.py --input_file="data/raw/eurovision.csv" --output_file="data/preprocessed/eurovision_data_preprocessed.csv"`

4. Run the analysis by running `src/eurovision_inferential_analysis.R`: \
`--input_path` should be the file path to the pre-processed data, \
`--output_dir` should be the path to the directory where the tables will be saved. \
`Rscript src/eurovision_inferential_analysis.R --input_file="data/preprocessed/eurovision_data_preprocessed.csv" --output_dir="results"`

### Option2: Running the make file
Before running the analysis through the make file, please use the code below to reset the repository-generated files. 
In the terminal, browse to the root folder of the repository and run:

    make clean

After using the `make clean` command to reproduce the analysis, use the command below in the repository's root folder.
Please ensure that you have followed the dependencies installation.

    make all


## Dependecies

We have created an environment ([eurovision_env.yaml](https://github.com/UBC-MDS/crdn/blob/main/environment.yaml)) for Python 3.10.6 in which the reproduction of our analysis can be done. To create this environment on your machine run: `conda env create -f eurovision_env.yaml`. Activate it by running: `conda activate eurovision_env`. The packages it uses are listed below:

- docopt==0.7.1
- ipykernel==6.17.1
- ipython==7.10.1
- vega_datasets==0.9.0
- altair_saver==0.1.0
- selenium==4.3.0
- pandas==1.5.1
- selenium==4.6.0.0
- pip==22.2.2
  - pandas_profiling
  - ipywidgets
  - vl-convert-python

Aside from this we used the following packages for R:

- tidyverse==1.3.2
- broom==1.0.1
- docopt==0.7.1
- pandoc==1.12.3 (Follow the installation guide [here](https://pandoc.org/installing.html))
  
## License

The materials of this project are licensed under the MIT License. If re-using/re-mixing please provide attribution and link to this webpage.

## References

Glejser, Herbert, and Bruno Heyndels. "Efficiency and inefficiency in the ranking in competitions: The case of the Queen Elisabeth Music Contest." *Journal of cultural Economics* 25, no. 2 (2001): 109-129.
