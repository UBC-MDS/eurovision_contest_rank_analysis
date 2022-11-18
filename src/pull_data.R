# author: Renzo Wijngaarden
# date: 2022-11-17

"A script that pulls a data set in csv form from the internet, and saves it 
to a specific folder in the Github repository as csv. 

Usage: pull_data.R --file_path=<file_path> --url=<url>

Options:
--file_path=<file_path>		Path to folder where the file will be saved, in quotes.
--url=<url>			url to the online dataset, in quotes.
" -> doc

library(docopt)

opt <- docopt(doc)

main <- function(folder_path, url) {

  # read in data
  data <- read.csv(url)

  # save the data to the specified file path
  write.csv(data, file_path)

}

main(opt$folder_path, opt$url)