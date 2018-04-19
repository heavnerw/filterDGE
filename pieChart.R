df <- data.frame(
  group = c("overlap ATACseq peaks", "do not overlap"),
  value = c(848, 13167)
)

head(df)

library(ggplot2)
bp <- ggplot(df, aes(x="", y=value, fill=group)) + geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y", start=0)
pie + scale_fill_brewer(palette = "Accent")
pie + scale_fill_manual(values=c("#E69F00", "#56B4E9"))
