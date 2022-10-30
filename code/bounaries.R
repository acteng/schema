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
summary(table(lads_tas_combined$name))

sf::write_sf(lads_tas_combined, "boundaries/lads_tas_combined.geojson", delete_dsn = TRUE)

# LPAs --------------------------------------------------------------------

# See https://geoportal.statistics.gov.uk/datasets/ons::local-planning-authorities-april-2022-uk-buc-3:
u = "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Local_Planning_Authorities_April_2022_UK_BUC_2022/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"
lpas = sf::read_sf(u)
lpas_england = lpas %>%
  filter(str_detect(LPA22CD, "E"))



# Tests -------------------------------------------------------------------

remotes::install_github("yonghah/esri2sf")
lads = esri2sf::esri2sf(url = u)