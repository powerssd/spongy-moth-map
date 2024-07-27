# required packages -----------------------------------------------------------
library(tidyverse)
library(ggrepel)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggspatial)

# objects for plotting North America
canada <- ne_states(country = "canada", returnclass = "sf")
usa <- ne_states(country = "united states of america", returnclass = "sf")

# location data for spongy moth
pop_locations <- 
  read_csv("Egg mass information Macrosystems 2018.csv")[c(-15, -16),] %>% 
  select(-Notes)

# shape file of the spongy moth quarantine zone in the United States
quarantine_us <- st_read("GM_Quarantine/GM_Quarantine_2018.shp")
st_geometry_type(quarantine_us)
st_crs(quarantine_us)

# plot of quarantine zone and spongy moth population locations
ggplot() +
  geom_sf(
    data = usa,
    fill = '#cccccc'
  ) +
  geom_sf(
    data = quarantine_us, 
    fill = '#636363', 
    color = '#cccccc'
  ) + 
  coord_sf(
    xlim = c(-126,-66),
    ylim = c(24.10, 50.10),
    expand = FALSE
  ) +
  geom_point(
    data = pop_locations,
    aes(
      x = Longitude, 
      y = Latitude, color = Latitude),
    size = 4
  ) +
  scale_color_gradient(low = "#de2d26", high = "#3182bd") +
  geom_text_repel(
    data = pop_locations,
    aes(
      x = Longitude, 
      y = Latitude, 
      label = Population
    ),
    size = 4,
    fontface = "bold"
  ) +
  annotation_scale(
    location = "bl", 
    width_hint = 0.2
  ) +
  coord_sf(
    xlim = c(-95.10, -65.10),
    ylim = c(24.10, 50.10),
    expand = FALSE
  ) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
  )