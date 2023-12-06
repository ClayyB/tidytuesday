## Create colour palettes

drwho_colours = list(
  space_colours = c("#030729", "#0a0338", "#0a0547", "#0d0658", "#0c096f"),
  tardis_colours = c("#00060b", "#00203c", "#003b6f", "#6f8ea9", "#a6b8c7"),
  scarf_colours = c("#a82624", "#d88529", "#805a36", "#62234e", "#544643")
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
