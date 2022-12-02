# Makefile
# Renzo Wijngaarden, Daniel Cairns, Mohammad Reza Nabizadeh, Crystal Geng
# 2022/12/01

# Eurovision Contest Rank Analysis

# This driver script completes the inferential analysis on the correlation
# of rank and running order in all editions of the Eurovision Songfestival.

# Example usage:
# make all

all : data/raw/eurovision.csv src/eda_data/figures data/preprocessed/eurovision_data_preprocessed.csv results doc/report.html

# The analysis can be reproduced by cloning the GitHub repository, installing
# the dependencies listed in the README, and running this Makefile:

# Download the data: 
data/raw/eurovision.csv: src/pull_data.R
	Rscript src/pull_data.R --file_path="data/raw/eurovision.csv" --url="https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-17/eurovision.csv"

# Create the exploratory analysis plots and save them: 
src/eda_data/figures: src/eurovision_eda.py data/raw/eurovision.csv
	python src/eurovision_eda.py --input_file="data/raw/eurovision.csv" --output_dir="src/eda_data/figures"

# Pre-process the data:
data/preprocessed/eurovision_data_preprocessed.csv: src/eurovision_preprocessing.py data/raw/eurovision.csv
	python src/eurovision_preprocessing.py --input_file="data/raw/eurovision.csv" --output_file="data/preprocessed/eurovision_data_preprocessed.csv"

# Run the analysis:
results: src/eurovision_inferential_analysis.R data/preprocessed/eurovision_data_preprocessed.csv
	Rscript src/eurovision_inferential_analysis.R --input_file="data/preprocessed/eurovision_data_preprocessed.csv" --output_dir="results"

# Create the report:
doc/report.html: doc/report.Rmd doc/references.bib results src/eda_data/figures
	Rscript -e "rmarkdown::render('doc/report.Rmd')"

clean:
	rm -rf data/raw/eurovision.csv
	rm -rf src/eda_data/figures/missing_values_plot.png
	rm -rf src/eda_data/figures/pair_wise_corr_plot.png
	rm -rf data/preprocessed/eurovision_data_preprocessed.csv
	rm -rf results/*.csv
	rm -rf doc/report.html