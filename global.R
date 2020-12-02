library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
devtools::install_github("rstudio/leaflet")
library(leaflet)

vgsales <- na.omit(read.csv('./data/vgsales.csv'))

vgsales <- vgsales %>%
  filter(Year != 'N/A')

vgsales2 <- vgsales %>% group_by(Platform, Year) %>%
  summarise(
    Genre = 'ALL Genre',
    NA_Sales = sum(NA_Sales),
    EU_Sales = sum(EU_Sales),
    JP_Sales = sum(JP_Sales),
    Global_Sales = sum(Global_Sales)
  )

vgsales3 <- vgsales %>% group_by(Genre, Year) %>%
  summarise(
    Platform = 'ALL Platform',
    NA_Sales = sum(NA_Sales),
    EU_Sales = sum(EU_Sales),
    JP_Sales = sum(JP_Sales),
    Global_Sales = sum(Global_Sales)
  )

vgsales4 <- vgsales %>% group_by(Year) %>%
  summarise(
    Platform = 'ALL Platform',
    Genre = 'ALL Genre',
    NA_Sales = sum(NA_Sales),
    EU_Sales = sum(EU_Sales),
    JP_Sales = sum(JP_Sales),
    Global_Sales = sum(Global_Sales)
  )

df_lst = list(vgsales, vgsales2, vgsales3, vgsales4)

vgsales <-
  list(vgsales, vgsales2, vgsales3, vgsales4) %>% bind_rows()

