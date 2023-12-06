library(ggplot2)

ggplot(richmondway, aes(x = Imdb_rating, y = F_count_RK)) +
  geom_point()

ggplot(richmondway, aes(Season, Episode)) +
  stat_bin2d()

ggplot(richmondway, aes(x = Episode, y = F_count_RK)) +
  geom_area()
