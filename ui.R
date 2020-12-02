

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
                           choices = unique(vgsales$Platform)),
            
            selectizeInput(inputId = "Region",
                           label = "Region",
                           choices = c('NA','EU','JP','Global'))
            
            
        ),
        mainPanel(
            tabsetPanel(
                tabPanel('Bestsellers and trends',
                         fluidRow(
                             column(6,plotOutput("top5")),
                             column(6,plotOutput('trend'))
                         )
                ),
                tabPanel('Map',
                         leafletOutput("mymap")
                ),
                tabPanel('Table',
                         dataTableOutput('table')
                         
                )
            )
        )
    ))
