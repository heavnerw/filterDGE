Layer5 <- data.frame(Transcript = factor(c("Ldb2", "Ldb2", "Ldb2", "Crym", "Crym", "Crym", "Cux2", "Cux2", "Cux2")), Stage = factor(c("E13.5", "E16.5", "E18.5", "E13.5", "E16.5", "E18.5", "E13.5", "E16.5", "E18.5"), levels=c("E13.5", "E16.5", "E18.5")), Transcript_Abundance = c(20.12, 118.43, 173.10, 6.37, 16.73, 55.93, 1.05, 0.29, 0.43))
Layer5
library(ggplot2)
ggplot(data=Layer5, aes(x=Stage, y=Transcript_Abundance, group=Transcript, shape=Transcript, color=Transcript)) + 
  geom_line(size=1) + 
  geom_point(size=3) + 
  scale_color_hue(name="Transcript") +
  xlab("Stage") + 
  ylab("Transcript Abundance") + 
  ggtitle("Changes in Expression Over Time") +
  theme(axis.title.x=element_text(size=62, face="bold")) +
  theme(axis.title.y=element_text(size=62, face="bold")) +
  theme(legend.text=element_text(size=68)) +
  theme_bw()
