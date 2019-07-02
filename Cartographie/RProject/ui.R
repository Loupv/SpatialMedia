library(shiny)
library(scatterD3)

fluidPage(
  titlePanel("SpatialMedia -  Cartographie des médiations spatiales"),
  
  tags$ul(tags$li(tags$a(href = "http://spatialmedia.ensadlab.fr/", "Lab website")),
          tags$li(tags$a(href = "https://github.com/juba/scatterD3", "scatterD3 on GitHub"))),
  
  
  # div(class="row",
  #     div(class="col-md-12",
  #         div(class="alert alert-warning alert-dismissible",
  #             HTML('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'),
  #             HTML("<strong>What you can try here :</strong>
  #                  <ul>
  #                  <li>Zoom on the chart with the mousewheel</li>
  #                  <li>Pan the plot</li>
  #                  <li>Drag text labels</li>
  #                  <li>Hover over a dot to display tooltips</li>
  #                  <li>Hover over the color or symbol legends items</li>
  #                  <li>Change data settings to see transitions</li>
  #                  <li>Resize the window to test for responsiveness</li>
  #                  <li>Try the lasso plugin with the toggle button or by using Shift+click</li>
  #                  <li>Click on a dot to open its associated URL (doesn't work in RStudio's internal browser)</li>
  #                  </ul>")))),
  sidebarLayout(
    sidebarPanel(
      sliderInput("scatterD3_nb", "Nombre d'observations",
                  min = 3, max = nrow(db), step = 1, value = nrow(db)),
      selectInput("scatterD3_x", "Variable X :",
                  choices = c(#"Timestamp",
                              "Time"	,
                              "Authorofthisform"	,
                              "Titleofthework"	,
                              "Releaseyear"	,
                              "Authors"	,
                              #"Genre"	,
                              # "Production"	,
                              # "Distribution"	,
                              # "PlateformURLlink"	,
                              # "TrailerURLlink"	,
                              # "OtherURLlink"	,
                              # "Creationsupport"	,
                              # "Visual"	,
                              # "PointofView"	,
                              # "ActivatedSenses",
                              # "Action"	,
                              # "Perception"	,
                              # "Medium"	,
                              # "Distributioncontext"	,
                              # "Interaction"	,
                              # "Dynamicsimulatorrowingmachinetreadmillseat"	,
                              # "Physically",
                              # "Virtually"	,
                              # "IfIhaveanavatar"	,
                              "EmotionalinvolvementAffectivity"	,
                              "FreedomofscenarioAgencyIcanImust"	,
                              "HybridityVirtualizationdegree"	,
                              "PresenceHowmuchdoIfeelbeinghere",
                              "Immersionqualityofthehardware"	,
                              "Generalsubjectivejudgement"	,
                              "IflinearDurationinminute"	,
                              # "Virtually"	,
                              # "OrganizationtypeCompany"	,
                              # "Association"		,
                              # "Administration"	,
                              # "Individual"	,
                              "IfnonlinearDurationinminuteindicatedbytheproducersdistributors"
                              #"IfnonlinearEstimateddurationinminute"	
                                ),
                  selected = "Releaseyear"),
      checkboxInput("scatterD3_x_log", "Echelle Logarithmique x", value = FALSE),
      
      selectInput("scatterD3_y", "Variable Y :",
                  choices = c(#"Timestamp",
                    "Time"	,
                    "Authorofthisform"	,
                    "Titleofthework"	,
                    "Releaseyear"	,
                    "Authors"	,
                    #"Genre"	,
                    # "Production"	,
                    # "Distribution"	,
                    # "PlateformURLlink"	,
                    # "TrailerURLlink"	,
                    # "OtherURLlink"	,
                    # "Creationsupport"	,
                    # "Visual"	,
                    # "PointofView"	,
                    # "ActivatedSenses",
                    # "Action"	,
                    # "Perception"	,
                    # "Medium"	,
                    # "Distributioncontext"	,
                    # "Interaction"	,
                    # "Dynamicsimulatorrowingmachinetreadmillseat"	,
                    # "Physically",
                    # "Virtually"	,
                    # "IfIhaveanavatar"	,
                    "EmotionalinvolvementAffectivity"	,
                    "FreedomofscenarioAgencyIcanImust"	,
                    "HybridityVirtualizationdegree"	,
                    "PresenceHowmuchdoIfeelbeinghere",
                    "Immersionqualityofthehardware"	,
                    "Generalsubjectivejudgement"	,
                    "IflinearDurationinminute"	,
                    # "Virtually"	,
                    # "OrganizationtypeCompany"	,
                    # "Association"		,
                    # "Administration"	,
                    # "Individual"	,
                    "IfnonlinearDurationinminuteindicatedbytheproducersdistributors"
                    #"IfnonlinearEstimateddurationinminute"	
                  ),
                  selected = "Time"),
      checkboxInput("scatterD3_y_log", "Echelle Logarithmique y", value = FALSE),
      
      selectInput("scatterD3_col", "Variable de mapping de Couleur :",
                  choices = c(
                    "None"= "None",
                    "Time"	,
                    "EmotionalinvolvementAffectivity"	,
                    "FreedomofscenarioAgencyIcanImust"	,
                    "HybridityVirtualizationdegree"	,
                    "PresenceHowmuchdoIfeelbeinghere",
                    "Immersionqualityofthehardware"	,
                    "Generalsubjectivejudgement"	,
                    "IflinearDurationinminute"	,
                    "IfnonlinearDurationinminuteindicatedbytheproducersdistributors"
                  ),
                  selected = "Time"),
      
      checkboxInput("scatterD3_ellipses", "Confidence ellipses", value = FALSE),
      sliderInput("scatterD3_ellipses_level", "Confidence ellipses level",
                  min = 0, max = 1, step = 0.01, value = 0.95),
      
      selectInput("scatterD3_symbol", "Variable de mapping de Symbole :",
                  choices = c("None"= "None",
                              #"Timestamp",
                              "Time"	,
                              "Authorofthisform"	,
                              "Titleofthework"	,
                              "Releaseyear"	,
                              "Authors"	,
                              #"Genre"	,
                              # "Production"	,
                              # "Distribution"	,
                              # "PlateformURLlink"	,
                              # "TrailerURLlink"	,
                              # "OtherURLlink"	,
                              # "Creationsupport"	,
                              # "Visual"	,
                              # "PointofView"	,
                              # "ActivatedSenses",
                              # "Action"	,
                              # "Perception"	,
                              # "Medium"	,
                              # "Distributioncontext"	,
                              # "Interaction"	,
                              # "Dynamicsimulatorrowingmachinetreadmillseat"	,
                              # "Physically",
                              # "Virtually"	,
                              # "IfIhaveanavatar"	,
                              "EmotionalinvolvementAffectivity"	,
                              "FreedomofscenarioAgencyIcanImust"	,
                              "HybridityVirtualizationdegree"	,
                              "PresenceHowmuchdoIfeelbeinghere",
                              "Immersionqualityofthehardware"	,
                              "Generalsubjectivejudgement"	,
                              "IflinearDurationinminute"	,
                              # "Virtually"	,
                              # "OrganizationtypeCompany"	,
                              # "Association"		,
                              # "Administration"	,
                              # "Individual"	,
                              "IfnonlinearDurationinminuteindicatedbytheproducersdistributors"
                              #"IfnonlinearEstimateddurationinminute"	
                         ),
                      selected = "Time"
                  ),
                  
      selectInput("scatterD3_size", "Variable de mapping de Taille :",
                  choices = c("None" = "None",
                              "EmotionalinvolvementAffectivity"
                              ),
                              selected = "None"),
                  
      checkboxInput("scatterD3_threshold_line", "Arbitrary threshold line", value = FALSE),    
      
      sliderInput("scatterD3_labsize", "Taille des Labels :",
                  min = 5, max = 25, value = 11),
      checkboxInput("scatterD3_auto_labels", "Automatic labels placement", value = TRUE),
      sliderInput("scatterD3_opacity", "Opacité des Points :", min = 0, max = 1, value = 1, step = 0.05),
      checkboxInput("scatterD3_transitions", "Transitions", value = TRUE),
      tags$p(actionButton("scatterD3-reset-zoom", HTML("<span class='glyphicon glyphicon-search' aria-hidden='true'></span> Reset Zoom")),
             actionButton("scatterD3-lasso-toggle", HTML("<span class='glyphicon glyphicon-screenshot' aria-hidden='true'></span> Toggle Lasso"), "data-toggle" = "button"),
             tags$a(id = "scatterD3-svg-export", href = "#",
                    class = "btn btn-default", HTML("<span class='glyphicon glyphicon-save' aria-hidden='true'></span> Télécharger SVG")))
      #tags$ul(tags$li(tags$a(href = "https://github.com/juba/scatterD3", "scatterD3 on GitHub")),
      #        tags$li(tags$a(href = "https://github.com/juba/scatterD3_shiny_app", "This app on GitHub")))
    ),
    mainPanel(scatterD3Output("scatterPlot", height = "700px"))
  )
  )