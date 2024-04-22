// Copyright (c) 2020 Kai Wang
// This software and associated documentation files are licensed under the MIT License. See the LICENSE file for details.


fluidPage(
    titlePanel("Video Games Sales"),
    sidebarLayout(
        sidebarPanel( 
            img(src='https://images.complex.com/complex/images/c_fill,dpr_auto,f_auto,q_90,w_1400/fl_lossy,pg_1/ym9ntmdjckmfdmtfmasr/video-games',width="100%"),
            selectizeInput(inputId = "Genre",
                           label = "Game Genre",
                           choices = unique(vgsales$Genre)),
            selectizeInput(inputId = "Platform",
                           label = "Game Platform",
                           #choices = unique(vgsales$Platform)
                           choices = NULL),
            
            selectizeInput(inputId = "Region",
                           label = "Region",
                           choices = c('NA','EU','JP','Global')),
            
            sliderInput("obs", "Starting years for comparison:",
                    
                        min = 1980, max = 2015, value = 10
            )
            
        ),
        mainPanel(
            tabsetPanel(
                tabPanel('Bestsellers and trends',
                         fluidRow(
                             column(6,plotOutput("top5")),
                             column(6,plotOutput('trend'))
                         )
                ),
            
                tabPanel('Region Comparison',
                         plotOutput("comparison_region")
                ),
                tabPanel('Genre Comparison',
                         plotOutput("comparison_genre")
                ),
                tabPanel('Platform Comparison',
                         plotOutput("comparison_platform")
                ),
                tabPanel('Table',
                         dataTableOutput('table')
                         
                )
            )
        )
    ))
