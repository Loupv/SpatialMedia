library(shiny)
library(scatterD3)
source("inprogress.R")

#database <- fillDatabase("Database_cartographie.csv")
database <- fillDatabase("Synthèse Questionnaire Cartographie 2019 - Form Responses corr.csv")

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
              tooltip_text =  paste(
                "Timestamp : ",data()[,"Timestamp"],"<br />", 
                "Time : ",data()[,"Time"],"<br />", 
                "Corpus number : ",data()[,"Corpus number"],"<br />", 
                "Author of this form : ",data()[,"Author of this form"],"<br />", 
                "Title of the work : ",data()[,"Title of the work"],"<br />", 
                "Release year : ",data()[,"Release year"],"<br />", 
                "Author(s) : ",data()[,"Author(s)"],"<br />", 
                "Genre : ",data()[,"Genre"],"<br />", 
                "Production : ",data()[,"Production"],"<br />", 
                "Distribution : ",data()[,"Distribution"],"<br />", 
                "Plateform : ",data()[,"Plateform"],"<br />", 
                "Plateform URL link : ",data()[,"Plateform URL link"],"<br />", 
                "Trailer URL link : ",data()[,"Trailer URL link"],"<br />", 
                "Other URL link : ",data()[,"Other URL link"],"<br />", 
                "Creation support : ",data()[,"Creation support"],"<br />", 
                "Visual : ",data()[,"Visual"],"<br />", 
                "Description : ",data()[,"Description"],"<br />", 
                "[Point of View] : ",data()[,"[Point of View]"],"<br />", 
                "[Activated Senses] : ",data()[,"[Activated Senses]"],"<br />", 
                "[Action] : ",data()[,"[Action]"],"<br />", 
                "[Perception] : ",data()[,"[Perception]"],"<br />", 
                "[Medium] : ",data()[,"[Medium]"],"<br />", 
                "Distribution context : ",data()[,"Distribution context"],"<br />", 
                "[Interaction] : ",data()[,"[Interaction]"],"<br />", 
                "Dynamic simulator (rowing machine, treadmill, seat...) : ",data()[,"Dynamic simulator (rowing machine, treadmill, seat...)"],"<br />", 
                "[Physically] : ",data()[,"[Physically]"],"<br />", 
                "[Virtually] : ",data()[,"[Virtually]"],"<br />", 
                "[If I have an avatar] : ",data()[,"[If I have an avatar]"],"<br />", 
                "[Emotional involvement / Affectivity] : ",data()[,"[Emotional involvement / Affectivity]"],"<br />", 
                "[Freedom of scenario / Agency (I can / I must)] : ",data()[,"[Freedom of scenario / Agency (I can / I must)]"],"<br />", 
                "[Hybridity / Virtualization degree] : ",data()[,"[Hybridity / Virtualization degree]"],"<br />", 
                "[Presence: How much do I feel being \"here\"?] : ",data()[,"[Presence: How much do I feel being \"here\"?]"],"<br />", 
                "[Immersion quality of the hardware] : ",data()[,"[Immersion quality of the hardware]"],"<br />", 
                "Clarify the virtualization degree: Penetration/Hybridization Real/Virtual/Real : ",data()[,"Clarify the virtualization degree: Penetration/Hybridization Real/Virtual/Real"],"<br />", 
                "Explain the sense of presence degree and how is it best generated: Esthetics, scenario, sound, freedom of action, medium, socialization... : ",data()[,"Explain the sense of presence degree and how is it best generated: Esthetics, scenario, sound, freedom of action, medium, socialization..."],"<br />", 
                "General subjective judgement : ",data()[,"General subjective judgement"],"<br />", 
                "If linear -> Duration in minute : ",data()[,"If linear -> Duration in minute"],"<br />", 
                "[Virtually] : ",data()[,"[Virtually]"],"<br />", 
                "Email Address : ",data()[,"Email Address"],"<br />", 
                "Organization type : ",data()[,"Organization type"],"<br />", 
                "[Company] : ",data()[,"[Company]"],"<br />", 
                "[Association] : ",data()[,"[Association]"],"<br />", 
                "[Administration] : ",data()[,"[Administration]"],"<br />", 
                "[Individual] : ",data()[,"[Individual]"],"<br />", 
                "If non linear -> Duration in minute indicated by the producers/distributors : ",data()[,"If non linear -> Duration in minute indicated by the producers/distributors"],"<br />", 
                "If non linear -> Estimated duration [(in minute)] : ",data()[,"If non linear -> Estimated duration [(in minute)]"],"<br />", 
                "[Virtually] : ",data()[,"[Virtually]"],"<br />", 
                "[Physically] : ",data()[,"[Physically]"],"<br />", 
                "Distribution channel : ",data()[,"Distribution channel"],"<br />", 
                "Estimated duration if no linear : ",data()[,"Estimated duration if no linear"],"<br />", 
                "Action liberty Indice : ",data()[,"Action liberty Indice"],"<br />", 
                "Mise en scene : ",data()[,"Mise en scene"],"<br />", 
                "[Sens Activé] : ",data()[,"[Sens Activé]"],"<br />", 
                "Other URL links2 : ",data()[,"Other URL links2"],"<br />"), 
              
                col_var = col_var,
              col_lab = input$scatterD3_col,
              ellipses = input$scatterD3_ellipses,
              ellipses_level = input$scatterD3_ellipses_level,
              symbol_var = symbol_var,
              symbol_lab = input$scatterD3_symbol,
              size_var = size_var,
              size_lab = input$scatterD3_size,
              url_var = data()[,"Other URL links"],
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