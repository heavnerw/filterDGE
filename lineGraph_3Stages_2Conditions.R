library(plyr)

setwd("~/")

data <- read.table("St18.txt", stringsAsFactors = FALSE, header=TRUE)

cdata <- ddply(data, "Condition", summarise,
               N    = length(Tpm),
               mean = mean(Tpm),
               sd   = sd(Tpm),
               se   = sd / sqrt(N)
)
cdata

St18 <- data.frame(Cell_Class = factor(c("DL", "DL", "DL", "UL", "UL", "UL")), Stage = factor(c("early", "mid", "late", "early", "mid", "late"), levels=c("early", "mid", "late")), TPM=c(13.68, 0.09, 0.00, , 0.20, 0.37), sd=c(23.29, 0.005, 0.02, 1.12, 0.03, 0.33), se=c(16.47, 0.004, 0.01, 0.80, 0.02, 0.24))
St18

library(ggplot2)
ggplot(data=St18, aes(x=Stage, y=TPM, group=Cell_Class, shape=Stage, color=Cell_Class)) + 
  geom_line(size=1) + 
  geom_point(size=3) + 
  scale_color_manual(name="Cell_Class", values=c("orange", "blue")) +
  xlab("Stage") + 
  ylab("TPM") + 
  ggtitle("Changes in Expression Over Time") +
  theme(axis.title.x=element_text(size=14, face="bold")) +
  theme(axis.title.y=element_text(size=14, face="bold")) +
  theme(axis.text=element_text(size=16, face="bold")) +
  theme(axis.text=element_text(size=16, face="bold")) +
  theme(legend.text=element_text(size=14)) +
  theme_bw() + geom_errorbar(aes(ymin=TPM-se, ymax=TPM+se), width=.1) + geom_line() + geom_point()
