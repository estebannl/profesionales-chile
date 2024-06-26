library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(labelled)
library(highcharter)

# Header ------------------------------------------------------------------

header_ <- dashboardHeader(
  title = "👩🏻‍🔬🇨🇱 Profesionales Chile 2010-2024",
  titleWidth = 400
)


# Sidebar -----------------------------------------------------------------

sidebar_ = dashboardSidebar(
  minified = F,
  collapsed = F,
  disable = F,
  
  br(),
  
  sidebarMenu(
    menuItem("Fuerza de trabajo profesional", tabName = "fuerza_trabajo", icon = icon("user-tie")),
    menuItem("Desocupación", tabName = "desocupa", icon = icon("arrow-trend-down")),
    menuItem("Subempleo por competencias", tabName ="sub_competencias", icon = icon("building-user")),
    menuItem("Metodología", tabName = "metodologia", icon = icon("gear"))
    ),
  br(),
 
  column(width = 12, 
         
         p(em("____________"), align = "center"),
         
         p(em("Construido con ShinyDashboard por Esteban Navarro"), class = "custom-font-subtitle-white",
           align = "center"),
         p(
           tags$div(
             style = "display: inline-block; margin: 0 20px;", 
             tags$a(href = "https://estebannl.netlify.app/", icon("briefcase", class = "my-custom-icon"))
           ),
           tags$div(
             style = "display: inline-block; margin: 0 10px;", 
             tags$a(href = "https://www.linkedin.com/in/nlesteban/", icon("linkedin", class = "my-custom-icon"))
           ),
           tags$div(
             style = "display: inline-block; margin: 0 20px;", 
             tags$a(href = "https://github.com/estebannl", icon("github", class = "my-custom-icon"))
           ),
           align = "center"
         ),
         
         br(),
         p(em("Para consultas o sugerencias no dudes en escribirme:"), class = "custom-font-subtitle-white",
           align = "center"),
         
         p(align = "center",
           tags$a("ernavarro@uc.cl",
                  href = "mailto:ernavarro@uc.cl", class = "custom-font-subtitle-white"))
         ),
         
         p(align = "center",
           tags$a(href = "mailto:ernavarro@uc.cl", icon("paper-plane", class = "my-custom-icon"))
           )
         

  )




# Body --------------------------------------------------------------------
body_ <- dashboardBody(
  
  
  # Define la fuente en el estilo CSS
  tags$head(
    tags$style(HTML("
      .custom-font-title {
        font-family: 'Raleway', sans-serif;
        font-size: 18px;
        color: #333333;
      }
                    "))
  ),
  # Estilo 2
  tags$head(
    tags$style(HTML("
      .custom-font-subtitle {
        font-family: 'Raleway', sans-serif;
        font-size: 12px;
        color: #333333;
      }
                    "))
  ),
  
  # Estilo 3
  tags$head(
    tags$style(HTML("
      .custom-font-subtitle-white {
        font-family: 'Raleway', sans-serif;
        font-size: 12px;
        color: #FFFFFF;
      }
                    "))
  ),
  
  
  # Estilo icon
  
  tags$head(
    tags$style(HTML("
      .my-custom-icon {
        font-size: 25px; /* Ajusta el tamaño del icono según sea necesario */
        /* Otros estilos personalizados si los necesitas */
      }
    "))
  ),
  
  tabItems(
    
    # Panel: Fuerza de trabajo ------------------------------------------------
    
    tabItem(
      tabName = "fuerza_trabajo",
      fluidRow(
        # Evolución de los graduados de educación superior 2010-2024
        column(width = 12,
               shinydashboard::box(width = 6,
                   
                   h4("Titulados y fuerza de trabajo con educación superior", class = "custom-font-title"),
                   h5("Personas de 25 o más años en Chile. Trimestre fma 2024", class = "custom-font-subtitle"),
                   
                   tableOutput("tab_general_ft")
                   ),
               shinydashboard::box(width = 6, 
                   highchartOutput("g_evol_esup", height = 300))
               ),
        
        # Evolución de la tasa de PARTICIPACION EN LA FT, de H y M
        column(width = 12,
               
               shinydashboard::box(width = 12,
                   column(width = 2,
                          selectInput(inputId = "select1",
                                      label = "Tipo de educación superior", 
                                      choices = c("Todos" = 0, 
                                                  "Técnica Superior" = 1 ,
                                                  "Universitaria" = 2),
                                      selected = 0),
                          p(strong("Tasa de participación"), ": número de personas 
                          en la fuerza de trabajo expresado como porcentaje 
                          de la población en edad de trabajar", class = "custom-font-subtitle"),
                          p(strong("Fuerza de trabajo"), ": personas en edad de 
                          trabajar que durante la semana de referencia cumplen 
                          los requisitos para ser incluidas en la categoría de 
                            ocupados o desocupados", class = "custom-font-subtitle")
                          
                          ),
                   
                   column(width = 6,
                          highchartOutput("g_evol_ft", height = 350)
                          ),
                   
                   column(width = 4,
                          highchartOutput("g_ft_sexo",height = 180),
                          highchartOutput("g_ft_edad",height = 180)
                          
                          )
                   )
               )
        )
      ),
    
    # Panel: Desocupación  ------------------------------------------------
    
    
    tabItem(tabName = "desocupa",
            
            h4("Página en desarrollo")
            
            
            
            ),
    tabItem(tabName = "sub_horario",
            h4("Página en desarrollo")),
    tabItem(tabName = "sub_competencias",
            h4("Página en desarrollo")),
    tabItem(tabName = "metodologia",
            h4("Página en desarrollo"))
  )
)

# Compilacion ui --------------------------------

dashboardPage(
  skin = "green",
  header = header_,
  sidebar = sidebar_,
  body = body_
)
