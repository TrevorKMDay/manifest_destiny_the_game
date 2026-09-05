



unique_scores <- events %>%
    select(date, id, matches("score|arank|states|b"), -states_total,
            -arank_last) %>%
    distinct() 

states_b <- unique_scores %>%
    pivot_longer(matches("^(score|states|arank|b)_"), 
                    names_to = c("score", "player"),
                    names_sep = "_") %>%
    pivot_wider(names_from = score, values_from = value)

corrr::correlate(states_b)

plot_sb <- ggplot(states_b, aes(x = score, y = b)) +
  geom_jitter(aes(color = player, alpha = date),
                width = 1, height = 0) +
  geom_smooth(method = "lm") +
  scale_y_continuous(limits = c(0, 60)) +
  theme_bw() +
  labs(title = "Area bonus against score", x = "Score",
        y = "B")

plot_sb
    
plot_stb <- ggplot(states_b, aes(x = states, y = b)) +
  geom_jitter(aes(color = player, alpha = date),
                width = 0.1) +
  geom_smooth(method = "lm") +
  scale_y_continuous(limits = c(0, 60)) +
  theme_bw() +
  labs(title = "Area bonus against score", x = "State count",
        y = "B")

plot_stb

plot_star <- ggplot(states_b, aes(x = states, y = arank)) +
  geom_jitter(aes(color = player, alpha = date),
                width = 0.1, height = 0.1) +
  geom_smooth(method = "lm") +
  scale_y_reverse() +
  theme_bw() +
  labs(title = "Area bonus against score", x = "State count",
        y = "B")

plot_star

plot_sar <- ggplot(states_b, aes(x = score, y = arank)) +
  geom_jitter(aes(color = player, alpha = date),
                width = 0.1, height = 0.1) +
  geom_smooth(method = "lm") +
  scale_y_reverse() +
  theme_bw() +
  labs(title = "Area bonus against score", x = "Score",
        y = "B")

plot_sar 

library(patchwork)

(plot_sb + plot_stb) / (plot_sar + plot_star) +
    plot_layout(axes = "collect", guides = 'collect')

