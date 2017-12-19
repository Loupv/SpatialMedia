library(shiny)
library(scatterD3)
source("inprogress.R")

database <- fillDatabase("Database_cartographie.csv")
d <- database
#d$names <- database$Oeuvres
#d$cyl_cat <- paste(d$cyl, "cylinders")
print(d)
default_lines <- data.frame(slope = c(0, Inf), 
                            intercept = c(0, 0),
                            stroke = "#000",
                            stroke_width = 1,
                            stroke_dasharray = c(5, 5))
threshold_line <- data.frame(slope = 0, 
                             intercept = 30, 
                             stroke = "#F67E7D",
                             stroke_width = 2,
                             stroke_dasharray = "")

function(input, output) {
  
  data <- reactive({
    d[1:input$scatterD3_nb,]
  })
  
  lines <- reactive({
    if (input$scatterD3_threshold_line) {
      return(rbind(default_lines, threshold_line))
    }
    default_lines
  })
  
  
  output$scatterPlot <- renderScatterD3({
    col_var <- if (input$scatterD3_col == "None") NULL else data()[,input$scatterD3_col]
    symbol_var <- if (input$scatterD3_symbol == "None") NULL else data()[,input$scatterD3_symbol]
    size_var <- if (input$scatterD3_size == "None") NULL else data()[,input$scatterD3_size]
    scatterD3(x = data()[,input$scatterD3_x],
              y = data()[,input$scatterD3_y],
              lab = data()[,"Oeuvres"],
              xlab = input$scatterD3_x,
              ylab = input$scatterD3_y,
              x_log = input$scatterD3_x_log,
              y_log = input$scatterD3_y_log,
              tooltip_text =  paste("Auteur : ",data()[,"Auteur"],"<br />", 
                                    "Date : ",data()[,"Date"],"<br />", 
                                    "Immersion : ",data()[,"Immersion"],"<br />", 
                                    "Libertee_action : ",data()[,"Libertee_action"],"<br />", 
                                    "Libertee_perception : ",data()[,"Libertee_perception"],"<br />", 
                                    "Socialisation : ",data()[,"Socialisation"],"<br />", 
                                    "Peripherique_entree : ",numToDeviceIn(data()[,"Peripherique_entree"]),"<br />", 
                                    "Peripherique_sortie : ",numToDeviceOut(data()[,"Peripherique_sortie"]),"<br />" ),
              col_var = col_var,
              col_lab = input$scatterD3_col,
              ellipses = input$scatterD3_ellipses,
              ellipses_level = input$scatterD3_ellipses_level,
              symbol_var = symbol_var,
              symbol_lab = input$scatterD3_symbol,
              size_var = size_var,
              size_lab = input$scatterD3_size,
              url_var = data()[,"URL"],
              key_var = rownames(data()),
              point_opacity = input$scatterD3_opacity,
              labels_size = input$scatterD3_labsize,
              transitions = input$scatterD3_transitions,
              left_margin = 90,
              lines = lines(),
              lasso = TRUE,
              caption = list(title = "Sample scatterD3 shiny app",
                             subtitle = "A sample application to show animated transitions",
                             text = "Yep, you can even use <strong>markup</strong> in caption text. <em>Incredible</em>, isn't it ?"),
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
}