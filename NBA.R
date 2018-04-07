#library(sqldf)
library(outliers)
library(Hmisc)
options(digits = 3)
path <- getwd()
stats <- read.csv("https://raw.githubusercontent.com/AddisonGauss/NbaData2015-2016/master/NBApoints.csv")
salaries <- read.csv("https://raw.githubusercontent.com/AddisonGauss/NbaData2015-2016/master/nbasalaries.csv")
nba <- merge.data.frame(stats, salaries, by = "Player")
drops <- c("X", "RK")
nba <- nba[, !(names(nba) %in% drops)]
colnames(nba)[30] <- "PS.G"
nba$SALARY <- substring(nba$SALARY, 2)
nba$SALARY <- substr(nba$SALARY, 1, nchar(nba$SALARY)-1)
nba$SALARY <- as.numeric(gsub(",","",nba$SALARY))
nba$Pos <- as.character(nba$Pos)
nba$Pos[match("PF-C", nba$Pos)] <- "PF"
nba$Pos[match("SG-SF", nba$Pos)] <- "SG"
nba <- nba[order(nba$PS.G, decreasing = T),]
nba$SALARY <- as.integer(nba$SALARY)
nba[which(is.na(nba[,14]), arr.ind = T),14] <- mean(nba[-which(is.na(nba[,14]), arr.ind = T),14])
nba[which(is.na(nba[,21]), arr.ind = T),21] <- mean(nba[-which(is.na(nba[,21]), arr.ind = T),21])
nba[379,c(11,14,17,18,21)] <- 0
nba[,33] <- (1.8 * nba$PS.G + 1.2 * nba$TRB + 1.5 * nba$AST + 2 * nba$STL + 2 * nba$BLK - 1.8 * nba$TOV) * nba$eFG.
colnames(nba)[33] <- "EVAL"
nba2 <- aggregate(nba[,c(4,6:30,32:33)], by = list(nba$TEAM), sum)
colnames(nba2)[1] <- "TEAM"
rownames(nba2) <- nba2$TEAM
nba2$TEAM <- NULL
nba3 <- scale(nba2)
dd <- dist(as.matrix(nba3), method = "euclidean")
#gr.com = cutree(hclust(dd, method = "complete"), k = 3)
#srednie.gr <-aggregate(nba2, by = list(gr.com), FUN = mean)
#View(nba)
#write.csv(nba, file = "nba.csv")
#grubbs.test(nba$PS.G, type=10)
#corr <- as.data.frame(subset(nba, select = c("SALARY", "PS.G")))
#cor(nba$SALARY,nba$PS.G, method = "spearman")
#plot(PS.G ~ SALARY, data = nba)
#model <- lm(PS.G ~ SALARY, data = nba)
#abline(model, col= "red")
#View(nba)
#tapply(nba$PS.G, nba$Pos, shapiro.test)
#bartlett.test(BLK~Pos, data = nba)
#kruskal.test(nba$EVAL~nba$Pos)
#model.0 <- lm(EVAL~1, data = nba)
#model.1 <- lm(EVAL~Pos, data = nba)
#anova(model.0,model.1)
#chisq.test(table(nba$Pos, nba$TRB))
#d1 <- data.frame(nba$Pos, nba$PS.G)
#summary(d1)
#plot(d1)
#tapply(nba$EVAL,nba$Pos, mean)
#shapiro.test(nba$BLK)
#M1 <- as.matrix(nba$EVAL, nba)

#klasyfikacja
#nba2 <- aggregate(nba[,c(4,6:30,32:33)], by = list(nba$TEAM), sum)
#colnames(nba2)[1] <- "TEAM"
#rownames(nba2) <- nba2$TEAM
#nba2$TEAM <- NULL
#nba2 <- scale(nba2)
#dd <- dist(as.matrix(nba2), method = "euclidean")
#print(dd)
#plot(hclust(dd,method="complete"),col = "gray0", col.main = "darkblue", col.lab = "darkblue",
#lwd = 2, lty = 5, sub = "", hang = -1, xlab = "Zespoły")
