## Load in data

source("~/Documents/tidy-tuesday/2023-12-05/load.R")

## Data wrangling

for (i in 1:length(drwho_episodes$episode_number)) {
  if (is.na(drwho_episodes$episode_number[i])) {
    message("Christmas")
    drwho_episodes$episode_number[i] = "Christmas"
  } else {
    message(drwho_episodes$episode_number[i])
  }
}

drwho_episodes %>%
  mutate(episode_number = factor(episode_number),
         episode_number = fct_recode(episode_number,
                                     "Christmas" = NA))

ep_lvls = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, "Christmas")

## Create colour palettes

drwho_colours = list(
  space_colours = c("#030729", "#0a0338", "#0a0547", "#0d0658", "#0c096f"),
  tardis_colours = c("#00060b", "#00203c", "#003b6f", "#6f8ea9", "#a6b8c7"),
  scarf_colours = c("#a82624", "#d88529", "#805a36", "#62234e", "#544643",
                    "#dbbc83", "#290c45", "#1d2661", "#33522f", "#869459",
                    "#7a7d80", "#f0e4bd", "#3d0404", "#692d00")
)

drwho_palettes = function(name, n, all_palettes = drwho_colours, type = c("discrete", "continuous")) {
  palette = all_palettes[[name]]
  if (missing(n)) {
    n = length(palette)
  }
  type = match.arg(type)
  out = switch(type,
               continuous = grDevices::colorRampPalette(palette)(n),
               discrete = palette[1:n]
  )
  structure(out, name = name, class = "palette")
}

scale_colour_drwho_d = function(name) {
  ggplot2::scale_colour_manual(values = drwho_palettes(name,
                                                       type = "discrete"))
}
scale_fill_drwho_d = function(name) {
  ggplot2::scale_fill_manual(values = drwho_palettes(name,
                                                     type = "discrete"))
}
scale_colour_drwho_c = function(name) {
  ggplot2::scale_colour_gradientn(colours = drwho_palettes(name = name,
                                                           type = "continuous"))
}
scale_fill_drwho_c = function(name) {
  ggplot2::scale_fill_gradientn(colours = drwho_palettes(name = name,
                                                         type = "continuous"))
}

scale_color_drwho_d = scale_colour_drwho_d
scale_color_drwho_c = scale_colour_drwho_c

## Google fonts

font_add_google(name = "Share Tech Mono", family = "share-tech-mono")

## Create heatmap

ggplot(drwho_episodes, aes(x = episode_number,
                 y = season_number,
                 fill = rating)) +
  geom_tile() +
  scale_fill_viridis_c(option = "magma") +
  labs(title = "Dr Who Episode Ratings",
       x = "Episode number",
       y = "Season number") +
  theme_void() +
  theme(text = element_text(family = "share-tech-mono"),
        plot.title = element_text(size = 20),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 90, vjust = 0.75),
        axis.text = element_text(size = 12))


## Create barchart

ggplot(drwho_episodes, aes(x = season_number,
                 y = uk_viewers,
                 fill = factor(episode_number))) +
  geom_col() +
  scale_fill_drwho_d("scarf_colours") +
  labs(title = "UK views per season, split on episode",
       x = "Season",
       y = "Number of viewers",
       fill = "Episode") +
  theme_minimal() +
  theme(text = element_text(family = "share-tech-mono"),
        plot.title = element_text(size = 20),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 90, vjust = 0.75),
        axis.text = element_text(size = 12))


