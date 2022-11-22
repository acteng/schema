# Aim: get boundary data
library(tidyverse)

# Local Authority Districts -----------------------------------------------
# See https://geoportal.statistics.gov.uk/search?q=local%20authority%20district&sort=-created&type=feature%20layer

u = "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Authority_Districts_May_2022_UK_BSC_V3/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"
lads = sf::read_sf(u)
lads_england = lads %>%
  filter(str_detect(LAD22CD, "E"))
nrow(lads_england)
# [1] 309
lads_england_tidy = lads_england %>%
  transmute(name = LAD22NM)

u = "https://github.com/udsleeds/openinfra/raw/main/data-small/lad_ta_region_lookup_atf3.csv"
tas_lookup = readr::read_csv(u)
# Sanity check:
summary(tas_lookup$LAD22NM %in% lads_england_tidy$name)
lads_joined = left_join(lads_england_tidy, tas_lookup %>% rename(name = LAD22NM))
tas = lads_joined %>%
  group_by(Region_name) %>%
  summarise(n_lads = n())
mapview::mapview(tas)
tas_clean = tas %>%
  transmute(name = Region_name)
sf::write_sf(tas_clean, "boundaries/tas_clean.geojson", delete_dsn = TRUE)
sf::write_sf(lads_england_tidy, "boundaries/lads_england_tidy_may_2022.geojson", delete_dsn = TRUE)

lads_tas_combined = rbind(
  tas_clean %>% mutate(level = "TA"),
  lads_england_tidy %>%
    mutate(level = "LAD") %>%
    filter(!name %in% tas_clean$name)
)

# summary(table(lads_tas_combined$name)) # 344
# duplicated_names = duplicated(lads_tas_combined$name)
# summary(duplicated_names)
# lads_tas_combined = lads_tas_combined %>%
#   distinct(name)

sf::write_sf(lads_tas_combined, "boundaries/lads_tas_combined.geojson", delete_dsn = TRUE)

# Avoid multipolygons -----------------------------------------------
library(tidyverse)
setwd("~/github/acteng/schema")
lads_tas_combined = sf::read_sf("boundaries/lads_tas_combined.geojson")
cornwall = lads_tas_combined %>%
  filter(name == "Cornwall")
sf::st_geometry_type(cornwall)
cornwall_polygons = sf::st_cast(cornwall, "POLYGON")
cornwall_polygons_small = cornwall_polygons |>
  arrange(area) |>
  slice(1:(n() - 1))
plot(cornwall_polygons_small)
cornwall_polygons_buffered = sf::st_buffer(cornwall_polygons_small, 1000)
cornwall_union = sf::st_union(c(cornwall_polygons_buffered$geometry, cornwall$geometry))
cornwall_union
mapview::mapview(cornwall_union)

# Generalise it:
x = lads_tas_combined
multi_polygon_to_polygons = function(x) {
  x_poly = sf::st_cast(x, "POLYGON")
  x_poly$area = sf::st_area(x_poly)
  x_poly_summary = x_poly %>%
    sf::st_drop_geometry() %>%
    group_by(across(1)) %>%
    summarise(n = n())
  x_mult_df = x_poly_summary %>%
    filter(n > 1) %>%
    select(-n)
  sel_x_multi = x_mult_df[[1]]
  if(length(sel_x_multi) == 0) {
    message("No multi-polygons")
    return(x)
  } else {
    message("Number of multipolygons: ", length(sel_x_multi))
    message("Polygonising these: ", paste(sel_x_multi, collapse = ", "))
    i = sel_x_multi[2]
    for(i in sel_x_multi) {
      n_x = which(x[[1]] == i)
      x_poly_i = x_poly %>%
        filter(across(1) == i)
      x_poly_i_small = x_poly_i |>
        arrange(area) |>
        slice(1:(n() - 1))
      x_poly_i_large = x_poly_i |>
        arrange(area) |>
        slice(n())
      distances = sf::st_distance(x_poly_i_small, x_poly_i_large)[, 1]
      distances = as.numeric(distances)
      for(j in seq_along(distances)) {
        dbuff = distances[j] + 100 # assuming 100m precision
        x_poly_i_small$geometry[j] = sf::st_buffer(x_poly_i_small$geometry[j], dbuff)
      }
      x_poly_i_union = sf::st_union(c(x_poly_i_small$geometry, x_poly_i_large$geometry))
      sf::st_geometry(x[n_x, ]) = x_poly_i_union
    }
  }
  x = sf::st_cast(x, "POLYGON")
  return(x)
}
x_poly = multi_polygon_to_polygons(x)
plot(x_poly[1, ])
plot(x[1, ])
x %>%
  filter(name == "Cornwall") %>%
  plot()
x_poly %>%
  filter(name == "Cornwall") %>%
  plot()

sf::write_sf(x_poly, "boundaries/lads_tas_combined.geojson", delete_dsn = TRUE)

# LPAs --------------------------------------------------------------------

# See https://geoportal.statistics.gov.uk/datasets/ons::local-planning-authorities-april-2022-uk-buc-3:
u = "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Planning_Authorities_April_2022_UK_BUC_2022/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"
lpas = sf::read_sf(u)
lpas_england = lpas %>%
  filter(str_detect(LPA22CD, "E"))



# Tests -------------------------------------------------------------------

remotes::install_github("yonghah/esri2sf")
lads = esri2sf::esri2sf(url = u)

library(tidyverse)
setwd("~/github/acteng/schema")
lads_tas_combined = sf::read_sf("boundaries/lads_tas_combined.geojson")
cornwall = lads_tas_combined %>%
  filter(name == "Cornwall")
sf::st_geometry_type(cornwall)
cornwall_polygons = sf::st_cast(cornwall, "POLYGON")
cornwall_polygons |>
  slice(2:3) |>
  plot()
cornwall_polygons = cornwall_polygons |>
  transmute(id = 1:n())
# cornwall_concave = concaveman::concaveman(cornwall, concavity = 3) # fail
cornwall_polygon_centroids = sf::st_centroid(cornwall_polygons)
cornwall_od = od::points_to_odl(cornwall_polygon_centroids)
plot(cornwall_od$geometry)
cornwall_od = cornwall_od %>%
  filter(O == 1)
plot(cornwall_od$geometry)
cornwall_od_buffer = sf::st_buffer(cornwall_od, 100)
mapview::mapview(cornwall_od_buffer)
cornwall_union = sf::st_union(c(cornwall_od_buffer$geometry, cornwall$geometry))
cornwall_union
mapview::mapview(cornwall_union)
