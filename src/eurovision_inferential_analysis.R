# author: Mohammad Reza Nabizadeh, Renzo Wijngaarden, Daniel Crains, Crystal Geng
# date: 2022-11-24

"Conducts inferential analysis on Eurovision data from a local file path and saves the tables as three csv files.

Usage: eurovision_inferential_analysis.R --input_file=<input_file> --output_dir=<output_dir>

Options:
--input_file=<input_file>   A String Path including the filename of the location to read the file locally.
--output_dir=<output_dir>   A String Path of the location to save the csv files locally.
" -> doc

# Load the packages 
library(tidyverse)
library(docopt)
library(broom)

opt <- docopt(doc)



main <- function(input_file, output_dir) {

  # Read the csv file
  eurovision_data <- read_csv(input_file)


  # Perform two-sample t-test on the entire dataset between the countries that perform the first and those that do not
  t_first_general <- t.test(
    formula = relative_rank ~ first_to_perform,
    data = eurovision_data,
    mu = 0,
    alternative = 'two.side',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Perform two-sample t-test on the entire dataset between the countries that perform the last and those that do not 
  t_last_general <- t.test(
    formula = relative_rank ~ last_to_perform,
    data = eurovision_data,
    mu = 0,
    alternative = 'two.side',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Compile the results of the two t-tests on the entire dataset
  result_general <- cbind(tibble("performing_order" = c("First", "Last"), rbind(t_first_general, t_last_general)))


  # Filter the data to only the results of semi finals
  semi_final_data <- eurovision_data %>%
    filter(section == "first-semi-final" | section == "second-semi-final" | section == "semi-final")

  # Perform two-sample t-test on the semi-final data between the countries that perform the first and those that do not
  t_first_semi_final <- t.test(
    formula = relative_rank ~ first_to_perform,
    data = semi_final_data,
    mu = 0,
    alternative = 'two.sided',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Perform two-sample t-test on the semi-final data between the countries that perform the last and those that do not
  t_last_semi_final <- t.test(
    formula = relative_rank ~ last_to_perform,
    data = semi_final_data,
    mu = 0,
    alternative = 'two.side',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Compile the results of the two t-tests on the semi-final data
  result_semi_final <- cbind(tibble("performing_order" = c("First", "Last"), rbind(t_first_semi_final, t_last_semi_final)))


  # Filter the data to only the results of finals
  final_data <- eurovision_data %>%
    filter(section == "grand-final" | section == "final")

  # Perform two-sample t-test on the final data between the countries that perform the first and those that do not 
  t_first_final <- t.test(
    formula = relative_rank ~ first_to_perform,
    data = final_data,
    mu = 0,
    alternative = 'two.sided',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Perform two-sample t-test on the final data between the countries that perform the last and those that do not 
  t_last_final <- t.test(
    formula = relative_rank ~ last_to_perform,
    data = final_data,
    mu = 0,
    alternative = 'two.side',
    conf.level = 0.95,
    var.equal = FALSE
    ) %>%
    tidy()

  # Compile the results of the two t-tests on the final data
  result_final <- cbind(tibble("performing_order" = c("First", "Last"), rbind(t_first_final, t_last_final)))
  
  
  # Export the output result dataframes as csv files 
  t_test_results_general_dataset_file <- paste0(output_dir, "/t_test_results_general_dataset.csv")
  t_test_results_semi_final_dataset_file <- paste0(output_dir, "/t_test_results_semi_final_dataset.csv")
  t_test_results_final_dataset_file <- paste0(output_dir, "/t_test_results_final_dataset.csv")

  write.csv(result_general, t_test_results_general_dataset_file, row.names = FALSE)
  write.csv(result_semi_final, t_test_results_semi_final_dataset_file, row.names = FALSE)
  write.csv(result_final, t_test_results_final_dataset_file, row.names = FALSE)

}

main(opt[["--input_file"]], opt[["--output_dir"]])