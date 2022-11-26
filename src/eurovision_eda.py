# author: Mohammad Reza Nabizadeh, Renzo Wijngaarden, Daniel Crains, Crystal Geng
# date: 2022-11-24

"""This script runs the EDA analytis over Eurovision data from a local filepath and saves
the two plots as png files into a local directory.

Usage: eurovision_eda.py --input_file=<input_file> --output_dir=<output_dir> 
 
Options:
--input_file=<input_file>   An String Path (including filename) of where to locally read the file.
"--output_dir"=<output_dir>   An String Path of where to locally save the png images.
"""
# Imporp dependencies
import pandas as pd
from docopt import docopt
import altair as alt
import vl_convert as vlc

# Handle large data sets without embedding them in the notebook
alt.data_transformers.disable_max_rows()



def save_chart(chart, filename, scale_factor=1):
    '''
    Attributed to: Joel Ostblom
    Save an Altair chart using vl-convert
    
    Parameters
    ----------
    chart : altair.Chart
        Altair chart to save
    filename : str
        The path to save the chart to
    scale_factor: int or float
        The factor to scale the image resolution by.
        E.g. A value of `2` means two times the default resolution.
    '''
    if filename.split('.')[-1] == 'svg':
        with open(filename, "w") as f:
            f.write(vlc.vegalite_to_svg(chart.to_dict()))
    elif filename.split('.')[-1] == 'png':
        with open(filename, "wb") as f:
            f.write(vlc.vegalite_to_png(chart.to_dict(), scale=scale_factor))
    else:
        raise ValueError("Only svg and png formats are supported")


opt = docopt(__doc__)

def main(input_file, output_dir):
    # Read the csv file
    raw_df = pd.read_csv(input_file, index_col=0)

    # Produce the missing values plot using AltAir marc_rect plots.
    missing_values_plot = alt.Chart(
        raw_df.sort_values(
            'year',
            ignore_index=True).isna().reset_index().melt(id_vars='index')).mark_rect().encode(
                alt.X('index:O', axis=None),
                alt.Y('variable', title=None),
                alt.Color('value', title='NaN'),
                alt.Stroke('value')).properties(
                    width=800,
                    title="The accurance of Null values in the dataset sorted based on the year").configure_title(
                        fontSize=20,
                        font='Cambria',
                        anchor='start').configure_axis(
                            labelFont='Cambria')
    
    # Filter the numeric columns for pair-wise correlation
    numeric_cols = raw_df.select_dtypes('number').columns.to_list()
    numeric_cols.remove('year')

    # Product the pair-wise correlation plot using AltAir mark_point plots.
    pair_wise_corr = alt.Chart(raw_df).mark_point(opacity=0.3, size=10).encode(
        alt.X(alt.repeat('column'), type='quantitative', scale=alt.Scale(zero=False)),
        alt.Y(alt.repeat('row'), type='quantitative', scale=alt.Scale(zero=False))
        ).properties(
            width=200,
            height=200
            ).repeat(
                row=numeric_cols,
                column=numeric_cols
                ).properties(
                    title="Pair-wise correlation of numeric columns in Eurovision dataset").configure_title(
                        fontSize=20,
                        font='Cambria',
                        anchor='start')
    
    outpt_missing_png = output_dir + '/missing_values_plot.png'
    save_chart(missing_values_plot, outpt_missing_png, 2)

    pair_wise_corr_png = output_dir + '/pair_wise_corr_plot.png'
    save_chart(pair_wise_corr, pair_wise_corr_png, 2)



if __name__ == "__main__":
    main(opt["--input_file"], opt["--output_dir"])