library(tidyverse)
library(shiny)
library(shinydashboard)
library(sf)
library(tmap)
tmap_mode("view")
pdf(file = NULL)

if(!file.exists("intervention.geojson")) {
library(osmdata)
intervention = opq(bbox = "leeds") %>%
  add_osm_feature(key = "name", value = "Cycle Superhighway 1", value_exact = FALSE) %>%
  osmdata_sf()
intervention = intervention$osm_multilines
sf::write_sf(intervention, "intervention.geojson")
}

intervention = sf::read_sf("intervention.geojson")
intervention = sf::st_sf(
  data = intervention %>% sf::st_drop_geometry(),
  geometry = intervention$geometry
)

ui = dashboardPage(
  dashboardHeader(title = "Intervention Data Dashboard"),
  dashboardSidebar(
    fileInput("file1", "Choose Geo File", accept = c(".gpkg", ".geojson", ".pdf")),
    selectInput(inputId = "type", label = "Intervention Type", choices = c("Off Road Dedicated Cycleway", "Dedicated Cycleway Parallel to Road", "...", "Other")),
    selectInput(inputId = "separation", label = "Separation type (if parallel to road)", choices = c("Car storage lane", "Grass verge", "...", "Other")),
    sliderInput(inputId = "separation_distance", label = "Average distance between edge of way and carriageway", min = 0, max = 5, value = 2, step = 0.1),
    sliderInput(inputId = "separation_distance_min", label = "Minimum distance between edge of way and carriageway", min = 0, max = 5, value = 2, step = 0.1),
    selectInput(inputId = "surface", label = "Surface", choices = c("Asfalt", "Gravel", "...", "Other")),
    sliderInput(inputId = "width", label = "Average width", min = 0, max = 5, value = 2, step = 0.1),
    sliderInput(inputId = "min_width", label = "Minimum width", min = 0, max = 5, value = 1.5, step = 0.1),
    sliderInput(inputId = "max_width", label = "Maximum width", min = 0, max = 5, value = 2.5, step = 0.1)

  ),
  dashboardBody(
    fluidRow(

    box(
      width = 4,
      textInput(inputId = "name", label = "Intervention name", value = "Intervention x on road y in town z"),
      textInput(inputId = "promoter", label = "Promoter", value = "Transport for ..."),
      sliderInput(inputId = "trips_without", label = "Number of trips per day without the proposed intervention", min = 0, max = 1000, value = 100),
      sliderInput(inputId = "trips_with", label = "Number of trips per day with the proposed intervention", min = 0, max = 1000, value = 110),
      sliderInput(inputId = "uptake", label = "Uptake", min = 0, max = 100, value = 5)
      ),
    box(
      width = 8,
      mapedit::selectModUI("map")
      # tmapOutput("map")
      )
    )
  )
)

server = function(input, output) {
  output$map = callModule(mapedit::editMod, "map", mapview::mapview(intervention)@map)
  # output$map = renderTmap(
  #   qtm(intervention) + tm_view(set.view = 12)
  #   # qtm()
  #   )
}

shinyApp(ui, server)

