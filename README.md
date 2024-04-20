# Video Game Sales Dashboard

This Shiny application provides an interactive dashboard to explore and analyze video game sales data across various dimensions including genre, platform, and geographical region. Users can visualize trends, compare metrics, and retrieve detailed information about video game sales from a comprehensive dataset.

## Features

- **Filtering Options**: Users can select a video game genre, platform, and region to focus the analysis on specific segments of the market.
- **Sales Trends Visualization**: Displays a line graph showing year-over-year sales trends based on the selected filters.
- **Comparison by Region**: Compare sales data across different regions in a point and line graph to see which geographical area performs best.
- **Comparison by Genre and Platform**: Allows users to compare how different genres and platforms perform over time through interactive graphs.
- **Top 5 Bestselling Games**: Highlights the top 5 games based on sales in the selected genre and platform.
- **Comprehensive Data Table**: Offers a detailed view of the video game sales data with options to filter and sort through the table.

## Data Source

The application utilizes the `vgsales.csv` dataset, which includes historical sales data for video games, including fields like game name, platform, year of release, genre, and sales in different regions.

## How to Run

To run this application locally, you will need to have R and Shiny installed on your system. Follow these steps:

1. Install R from [CRAN](https://cran.r-project.org/mirrors.html).
2. Install the required R packages by running the following commands in R:
   ```R
   install.packages("shiny")
   install.packages("dplyr")
   install.packages("ggplot2")
   install.packages("data.table")
Clone this repository or download the app files to your local machine.
Set the working directory to the app directory using setwd("path/to/app") in R.
Run the app by executing:
R
Copy code
shiny::runApp()
App Structure

global.R: Loads the necessary libraries and preprocesses the data.
ui.R: Defines the user interface for the Shiny app.
server.R: Contains the server logic to reactively update the plots and data tables based on user input.


Limitations and Future Work

Current data extends only through 2015; future updates could include more recent data.
Additional features like predictive analytics could be integrated to forecast future trends.
Contributing

Contributions to improve the app are welcome. Please fork the repository and submit a pull request with your enhancements.

License

This project is open-sourced under the MIT License. See the LICENSE file for more details.
