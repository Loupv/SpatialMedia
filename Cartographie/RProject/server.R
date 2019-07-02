library(shiny)
library(scatterD3)
source("inprogress.R")

#database <- fillDatabase("Database_cartographie.csv")
db <- fillDatabase("test.csv")


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
    db[1:input$scatterD3_nb,]
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
    auto_label <- if (!input$scatterD3_auto_labels) NULL else "auto"
    scatterD3(x = data()[,input$scatterD3_x],
              y = data()[,input$scatterD3_y],
              lab = unlist(data()[,"Titleofthework"]),
              xlab = input$scatterD3_x,
              ylab = input$scatterD3_y,
              x_log = input$scatterD3_x_log,
              y_log = input$scatterD3_y_log,
              tooltip_text =  paste(
                "Titleofthework : <strong>"	,data()[,"Titleofthework"],"</strong><br />", 
                "Release Year : "	,data()[,"Releaseyear"],"<br />",  
                "Authors : "	,data()[,"Authors"],"<br />", 
                "Emotional involvement Affectivity : "	,data()[,"EmotionalinvolvementAffectivity"],"<br />", 
                "Freedom of scenario: Agency/I can/I must : "	,data()[,"FreedomofscenarioAgencyIcanImust"],"<br />", 
                "Hybridity Virtualization degree : "	,data()[,"HybridityVirtualizationdegree"],"<br />", 
                "Presence - How much do I feel being here : "	,data()[,"PresenceHowmuchdoIfeelbeinghere"],"<br />", 
                "Immersion quality of the hardware : "	,data()[,"Immersionqualityofthehardware"],"<br />", 
                "General subjective judgement : "	,data()[,"Generalsubjectivejudgement"],"<br />", 
                "Duration in minute (If linear) : "	,data()[,"IflinearDurationinminute"],"<br />", 
                "Duration in minute (producers) : ",data()[,"IfnonlinearDurationinminuteindicatedbytheproducersdistributors"],"<br />",
                "-- Author of this form : "	,data()[,"Authorofthisform"],"<br />"
              ),
              col_var = col_var,
              col_lab = input$scatterD3_col,
              ellipses = input$scatterD3_ellipses,
              ellipses_level = input$scatterD3_ellipses_level,
              symbol_var = symbol_var,
              symbol_lab = input$scatterD3_symbol,
              size_var = size_var,
              size_lab = input$scatterD3_size,
              #url_var = data()[,"Visual"],
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
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}"
              )
  })
}