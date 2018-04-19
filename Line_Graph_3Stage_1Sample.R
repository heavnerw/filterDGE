
DL <- c(96921, 73307, 73438)

plot(DL, type="o", col="orange", ylim=c(20000,114000), axes=FALSE, ann=FALSE, lwd=8)

axis(1, at=1:3, lab=c("E13.5", "E16.5", "E18.5"))
axis(2, las=2, at=10000*0:114000)
box()
title(main="Number of Replicated Peaks")

title(xlab="Stage", col.lab=rgb(0,0,0))
title(ylab="peaks", col.lab=rgb(0,0,0))
legend("topright", c("Deep Layers"), cex=0.9, col=c("orange"), pch=21, lwd=2)

