"""Applies pre-processing steps to the raw data file to prepare it for further statistical analysis

Usage: eurovision_preprocessing.py --input_file=<input_file> --output_file=<output_file> 
 
Options:
--input_file=<input_file>   Path to the raw data file
--output_file=<output_file>   Path to save the output file after preprocessing is complete
"""

import pandas as pd
import numpy as np
import math
from docopt import docopt

opt = docopt(__doc__)


def main(input_file, output_file):
    raw_df = pd.read_csv(input_file, index_col=0)

    trimmed_df = raw_df.drop(columns=['event_url', 'artist', 'song', 'artist_url', 'image_url', 'country_emoji'])
    trimmed_df.drop(trimmed_df[trimmed_df.year == 1956].index, inplace=True) # Drop 1956 because rank is not proper in this year
    trimmed_df.drop(trimmed_df[trimmed_df.year == 2020].index, inplace=True) # Drop 2020 because covid
    #trimmed_df.drop(trimmed_df[trimmed_df.section == 'semi-final'].index, inplace=True) # Drop non-finals
    #trimmed_df.drop(trimmed_df[trimmed_df.section == 'first-semi-final'].index, inplace=True) # Drop non-finals
    #trimmed_df.drop(trimmed_df[trimmed_df.section == 'second-semi-final'].index, inplace=True) # Drop non-finals

    prepped_df = trimmed_df.copy()
    prepped_df['winner'] = np.where(prepped_df['winner'] == True, 1, 0)
    prepped_df['qualified'] = np.where(prepped_df['qualified'] == True, 1, 0)

    #Helper Columns
    prepped_df['event-section'] = prepped_df['event'] + prepped_df['section']
    contestants_per_contest = prepped_df['event-section'].value_counts().sort_index()
    prepped_df['section_contestants'] = prepped_df['event-section'].apply(lambda x: contestants_per_contest.loc[x])

    #Prepped Columns - Features to Test
    prepped_df['relative_order'] = prepped_df['running_order'] / prepped_df['section_contestants']
    prepped_df['first_to_perform'] = np.where(prepped_df['running_order'] == 1, 1, 0)
    prepped_df['last_to_perform'] = np.where(prepped_df['running_order'] == prepped_df['section_contestants'], 1, 0)
    prepped_df['is_host_country'] = np.where(prepped_df['host_country'] == prepped_df['artist_country'], 1, 0)

    #Prepped Columns - Targets to Test
    prepped_df['relative_rank'] = (prepped_df['section_contestants'] - prepped_df['rank'] + 1) / prepped_df['section_contestants']
    prepped_df['rank_quintiles'] = prepped_df['relative_rank'].apply(lambda x: 6 - math.ceil(5 * x))

    output_df = prepped_df.filter(['section','relative_order', 'first_to_perform', 'last_to_perform', 'relative_rank']).reset_index()
    output_df.to_csv(output_file)
    

if __name__ == "__main__":
    main(opt["--input_file"], opt["--output_file"])


