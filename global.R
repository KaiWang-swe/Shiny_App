// Copyright (c) [year] [your full name]
// This software and associated documentation files are licensed under the MIT License. See the LICENSE file for details.


library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)


vgsales <- na.omit(read.csv('./data/vgsales.csv'))


v.na=select(vgsales,Name,Platform,Year,Genre,sales=NA_Sales)
colnames(v.na)
v.na$Region='NA'
head(v.na)
v.eu=select(vgsales,Name,Platform,Year,Genre,sales=EU_Sales)
v.eu$Region='EU'
v.jp=select(vgsales,Name,Platform,Year,Genre,sales=JP_Sales)
v.jp$Region='JP'
v.gb=select(vgsales,Name,Platform,Year,Genre,sales=Global_Sales)
v.gb$Region='Global'
v <- list(v.na,v.eu,v.jp,v.gb) %>% bind_rows()
v <- v %>%
  filter(Year != 'N/A')

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
colnames(vgsales)


