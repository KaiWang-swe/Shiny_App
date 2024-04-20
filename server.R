// Copyright (c) [year] [your full name]
// This software and associated documentation files are licensed under the MIT License. See the LICENSE file for details.



function(input, output, session) {
    # first navbar
    
    vgsales_db <- reactive({
        vgsales %>% filter(Genre == input$Genre)
    })
    
    observeEvent(input$Genre, {
        choices = unique(vgsales_db()['Platform'])
        updateSelectizeInput(session, inputId = 'Platform', choices = choices)
    })
    
    output$trend <- renderPlot(
        vgsales %>%
            filter(Year>input$obs) %>% 
            filter(Genre == input$Genre &
                       Platform == input$Platform) %>%
            select(Year, 'sales' = starts_with(input$Region, ignore.case = F)) %>%
            group_by(Year) %>%
            summarise(n = sum(sales)) %>%
            ggplot(aes(x = Year, y = n)) +
            geom_line(group = 1,color='lightblue') +
            ggtitle('Year over year trend ') +
            theme_bw() +
            ylab('Sales in millions')
    )
    
    
 
    
    
    output$comparison_region <- renderPlot(
        
        v %>%
            select(Year,sales,Region) %>% 
            filter(Year>input$obs) %>% 
            group_by(Year,Region) %>% 
            summarise(sales=sum(sales))  %>% 
            ggplot(aes(x = Year,y=sales)) +
            geom_point(aes(color=Region)) +
            ggtitle('Compare Region') +
            theme_bw() +
            ylab('Sales in millions')+
            geom_line(aes(group=Region,color=Region))
    )
    
    genre_name <- v %>%
        select(Year,sales,Genre) %>% 
        group_by(Genre) %>% 
        summarise(sales=sum(sales)) %>% 
        top_n(10,sales) 
    genre_name$Genre
    
    output$comparison_genre <- renderPlot(
        
        v %>%
            select(Year,sales,Genre) %>% 
            filter(Year>input$obs) %>% 
            filter(Genre %in% genre_name$Genre) %>% 
            group_by(Year,Genre) %>% 
            summarise(sales=sum(sales))  %>% 
            ggplot(aes(x = Year,y=sales)) +
            geom_point(aes(shape=Genre,color=Genre)) +
            ggtitle('Compare Genre') +
            theme_bw() +
            ylab('Sales in millions')+
            geom_line(aes(group=Genre,color=Genre))
    )
    
    
    platform_name <- v %>%
        select(Year,sales,Platform) %>% 
        group_by(Platform) %>% 
        summarise(sales=sum(sales)) %>% 
        top_n(15,sales) 
    platform_name$Platform
    
    output$comparison_platform <- renderPlot(
        
        v %>%
            select(Year,sales,Platform) %>% 
            filter(Year>input$obs) %>% 
            filter(Platform %in% platform_name$Platform) %>% 
            group_by(Year,Platform) %>% 
            summarise(sales=sum(sales))  %>% 
            ggplot(aes(x = Year,y=sales)) +
            geom_point(aes(shape=Platform,color=Platform)) +
            ggtitle('Compare Platform') +
            theme_bw() +
            ylab('Sales in millions')+
        geom_line(aes(group=Platform,color=Platform))
    )
            
    
    
    
    
    
    
    
    output$top5 <- renderPlot(
        vgsales %>%
            filter(Genre == input$Genre &
                       Platform == input$Platform)
        %>% select(
            Name,
            Platform,
            Year,
            Genre,
            Publisher,
            'sales' = starts_with(input$Region, ignore.case = F)
        ) %>%
            top_n(5, sales) %>%
            group_by(Publisher) %>%
            summarise(Name = Name, Sales = as.numeric(sales)) %>%
            arrange(desc(Sales)) %>%
            
            ggplot(aes(
                x = reorder(Name, Sales), y = Sales
            )) +
            geom_col(fill = "lightblue") +
            ggtitle("Top 5 bestselling games") +
            coord_flip() +
            theme_bw() +
            xlab("Games") +
            ylab('Sales in millions')
    )
    output$table <- renderDataTable(vgsales)
    
   
}

