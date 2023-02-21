# Packages ----
library(shiny) 
library(shinydashboard)
library(ggplot2)
library(dplyr)  
library(shinyjs)
library(learnr)

# ui.R ----
ui <- fluidPage(
  ## set up shinyjs
  useShinyjs(),
  title = "SRS Project",
  ## CSS style file
  includeCSS("www/styles.css"),
  div(id = "landing_page",
      div(
        ## title
        h1("Choose your dataset")),
      br(),
      ## Buttons for each experiment
      div(class = "all_buttons",
          div(id = "penguin", class = "mid",
              actionButton("penguin_butt",div(class = "container",img(src = "img/penguin.png"),
                                            br(), br(), br(), br(), h3("Tutorial")),
                           class = "penguin_btn")),
          div(id = "pokemon", class = "mid",
              actionButton("pokemon_butt",div(class = "container",img(src = "img/pokemon.png"),
                                            h3("Exercise")),
                           class = "pokemon_btn"))
      )),
  
  ## Hidden experiment pages
  ## Tomato
  shinyjs::hidden(div(id = "hidden_page_penguin",
                      div(id = "back_to_landing_penguin", 
                          tags$a(class="btn btn-primary", icon("arrow-left"), h4("Back to landing page"))),
                      br(),
                      htmlOutput("frame1"))),
  
  ## Chicks
  shinyjs::hidden(div(id = "hidden_page_pokemon",
                      div(id = "back_to_landing_pokemon", 
                          tags$a(class="btn btn-primary", icon("arrow-left"), h4("Back to landing page"))),
                      br(),
                      htmlOutput("frame2"))))




# server.R ----
server <- function(input, output,session) {
  
  output$frame1 <- renderUI({
    tags$iframe(
      src="http://daniel-heslop.shinyapps.io/SRS_Project_Tut", width=1650, height=875
    )
  })
  
  output$frame2 <- renderUI({
    tags$iframe(
      src="http://daniel-heslop.shinyapps.io/PracticeTutorial", width=1650, height=875
    )
  })
  
  ## go back to landing page
  observe({
    onclick("back_to_landing_penguin", {
      shinyjs::show("landing_page")
      shinyjs::hide("hidden_page_penguin")
      shinyjs::removeClass(selector = "body", class = "hidden_page_penguin")
    })
  })
  observe({
    onclick("back_to_landing_pokemon", {
      shinyjs::show("landing_page")
      shinyjs::hide("hidden_page_pokemon")
      shinyjs::removeClass(selector = "body", class = "hidden_page_pokemon")
    })
  })
  observe({
    onclick("back_to_landing_pump", {
      shinyjs::show("landing_page")
      shinyjs::hide("experiment_page_pump")
      shinyjs::removeClass(selector = "body", class = "experiment_page_pump")
    })
  })
  ## load hidden pages
  observe({
    onclick("penguin_butt", {
      shinyjs::hide("landing_page")
      shinyjs::show("hidden_page_penguin")
      shinyjs::removeClass(selector = "body", class = "landing_page")
    })
  })
  observe({
    onclick("pokemon_butt", {
      shinyjs::hide("landing_page")
      shinyjs::show("hidden_page_pokemon")
      shinyjs::removeClass(selector = "body", class = "landing_page")
    })
  })
  observe({
    onclick("pump_butt", {
      shinyjs::hide("landing_page")
      shinyjs::show("experiment_page_pump")
      shinyjs::removeClass(selector = "body", class = "landing_page")
    })
  })
  
  
  
}                
         
# Run the app ----
shinyApp(ui = ui, server = server)
                      


