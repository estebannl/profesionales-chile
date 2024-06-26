library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(labelled)
library(highcharter)

# Carga data y funciones

load("20240621_tablas_fuerza_trabajo.RData")
# load("20240621_desocupacion.RData")
source("00_funciones_graficos.R")

# Server

function(input, output, session) {

  output$g_evol_esup = renderHighchart({
    
    t_evol_esup %>% 
      filter(educ_tipo %in% c(1,2)) %>% 
      select(educ_tipo, periodo, N, N_low, N_upp) %>% 
      mutate_if(is.labelled, to_character) %>% 
      hchart(type = "column",
             hcaes(x = periodo, y = N, group = educ_tipo)) %>% 
      hc_plotOptions(column = list(
        stacking = "normal",
        pointPadding = 0,  # Ajustar el espacio entre columnas individuales
        groupPadding = 0  # Ajustar el espacio entre grupos de columnas
      )) %>% 
      hc_xAxis(title = list(text = "")) %>% 
      hc_yAxis(title = list(text = "N estimado"), max = 5000000) %>% 
      hc_title(text = "Titulados de educación superior 2010-2024", align = "left") %>%
      hc_subtitle(text = "Personas de 25 años o más, según tipo de educación", align = "left") %>%
      hc_tooltip(shared = TRUE, crosshairs = TRUE) %>% 
      hc_add_theme(hc_theme_elementary2(plt = plt3))
  })
  
  output$g_evol_ft = renderHighchart({
    
    t_evol_participa %>% 
      filter(educ_tipo == as.numeric(input$select1), ft == 1) %>% 
      select(periodo,sexo, pct, pct_low, pct_upp) %>% 
      mutate_if(is.labelled, to_character) %>% 
      hchart(type = "line",
             hcaes(x = periodo, y = pct, group = sexo)) %>% 
      hc_plotOptions(column = list(
        stacking = "normal",
        pointPadding = 0,  # Ajustar el espacio entre columnas individuales
        groupPadding = 0  # Ajustar el espacio entre grupos de columnas
      )) %>% 
      hc_xAxis(title = list(text = "")) %>% 
      hc_yAxis(title = list(text = "Tasa de participación"),min = 50, max = 100) %>% 
      hc_title(text = "Tasa de participación en la fuerza de trabajo 2010-2024", align = "left") %>%
      hc_subtitle(text = "Personas de 25 años o más con educación superior. General y según sexo", align = "left") %>%
      hc_tooltip(shared = TRUE, crosshairs = TRUE) %>% 
      hc_add_theme(hc_theme_elementary2(plt = plt2))
  })
  
  output$g_ft_sexo = renderHighchart({
    
    ft_sexo %>% 
      filter(educ_tipo == as.numeric(input$select1)) %>%
      select(educ_tipo, sexo, pct, pct_low, pct_upp) %>% 
      mutate_if(is.labelled, to_character) %>% 
      hchart(type = "bar",
             hcaes(x = sexo, y = pct),
             dataLabels = list(enabled = TRUE)) %>% 
      hc_plotOptions(bar = list(
        pointPadding = 0.1  # Ajustar el espacio entre columnas individuales
      )) %>% 
      hc_title(text = "Distribución de la fuerza de trabajo", align = "left") %>%
      hc_subtitle(text = "Por categorías de sexo y edad. Trimestre fma 2024", align = "left") %>%
      hc_xAxis(title = list(text = "")) %>% 
      hc_yAxis(title = list(text = ""),min = 0, max = 60) %>% 
      hc_add_theme(hc_theme_elementary2(plt = plt3))
  })
  
  
  output$g_ft_edad = renderHighchart({
    
    ft_edad %>% 
      filter(educ_tipo == as.numeric(input$select1)) %>%
      select(educ_tipo, edad5, pct, pct_low, pct_upp) %>% 
      mutate_if(is.labelled, to_character) %>% 
      hchart(type = "bar",
             hcaes(x = edad5, y = pct),
             dataLabels = list(enabled = TRUE)) %>% 
      hc_plotOptions(bar = list(
        pointPadding = 0.01  # Ajustar el espacio entre columnas individuales
      )) %>% 
      hc_xAxis(title = list(text = "")) %>% 
      hc_yAxis(title = list(text = "% estimado"),min = 0, max = 60) %>% 
      hc_add_theme(hc_theme_elementary2(plt = plt3))
  })
  
  output$tab_general_ft = renderTable({
    
    t_general_ft}, digits = 0, align = "c")
  
  
}