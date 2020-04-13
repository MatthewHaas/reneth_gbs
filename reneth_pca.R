# Load required package.
library(data.table)

# Read in eigenvectors to plot PCA
x <- fread("reneth_plink_pca.eigenvec")

# Remove column 2 (redundant)
x[, V2 := NULL]

# Load in sample key
y <- fread("~/reneth_gbs/reneth_sample_key.csv")

# set column names
setnames(x, c("sample", "PC1", "PC2", "PC3", "PC4", "PC5", "PC6", "PC7", "PC8", "PC9", "PC10", "PC11", "PC12", "PC13",
			"PC14", "PC15", "PC16", "PC17", "PC18", "PC19", "PC20"))

# Shorten sample name (change from directory path format) so that it can be merged with data table y
x[, sample := sub("/.+$", "", sample)]

# Read in eigenvalues (to determine % variation explained by each PC)
v <- fread("reneth_plink_pca.eigenval")


# Calculate percent variation (note: I didn't bother renaming the columns to something informative since there is only one)
percentVar = c(PC1=v[1, V1] / sum(v$V1), PC2=v[2, V1] / sum(v$V1), PC3=v[3, V1] / sum(v$V1), PC4=v[4, V1] / sum(v$V1), PC5=v[5, V1] / sum(v$V1), PC6=v[6, V1] / sum(v$V1), PC7=v[7, V1] / sum(v$V1), PC8=v[8, V1] / sum(v$V1))

# Merge data tables
x[y, on="sample"] -> z

# Remove Claudia's 4 samples from consideration
z <- z[trait != "claudia sample"]

# Color points according to trait
z[trait == "flag leaf length", col := "black"]
z[trait == "flag leaf width", col := "red"]
z[trait == "male floret shattering", col := "salmon"]
z[trait == "female panicle length", col := "orange"]
z[trait == "male panicle length", col := "yellow"]
z[trait == "main stem width", col := "green"]
z[trait == "male floret color: white" | trait == "male floret color: purple" | trait == "male floret color: light purple" | trait == "male floret color: dark purple", col := "darkgreen"]
z[trait == "male panicle type" | trait == "male panicle type: bottlebrush" | trait == "male panicle type: normal", col := "mediumblue"]
z[trait == "plant height", col := "purple"]
z[trait == "seed on panicle", col := "darkmagenta"]
z[trait == "seed shatter", col := "maroon"]
z[trait == "all", col := "grey"]

# Save today's date as an object for use in filenames. This will prevent overwriting previous files by mistake
date <- Sys.Date()
today <- format(date, format="%y%m%d")

# Make plot
pdf(paste0(today, "_reneth_gbs.pdf"), height=12, width=16)
par(oma=c(2,2,2,2))
z[, plot(PC1, PC2, xlab=paste0("PC1: ", round(percentVar[1]*100), "%"), ylab=paste0("PC2: ", round(percentVar[2]*100), "%"), main="Itasca-C12 bulk", pch=16, col=col, cex=2.5, yaxt='n', cex.axis=1.5, cex.lab=1.5, family = "serif")]
axis(2, las=1, cex.lab=1.5, cex.axis=1.5, family = "serif")

legend("bottomright", legend=c("flag leaf length", "flag leaf width", "male floret shattering", "female panicle length", "male panicle length", "main stem width", "male floret color", "male panicle type", "plant height", "seed on panicle", "seed shatter", "all"), col=c("black", "red", "salmon", "orange", "yellow", "green", "darkgreen", "mediumblue", "purple", "darkmagenta", "maroon", "grey"), pch=16, ncol=3, cex=1.2)

z[, plot(PC2, PC3, xlab=paste0("PC2: ", round(percentVar[2]*100), "%"), ylab=paste0("PC3: ", round(percentVar[3]*100), "%"),  main="Itasca-C12 bulk", pch=16, col=col, cex=2.5, yaxt='n', cex.axis=1.5, cex.lab=1.5, family = "serif")]
axis(2, las=1, cex.lab=1.5, cex.axis=1.5, family = "serif")

legend("topleft", legend=c("flag leaf length", "flag leaf width", "male floret shattering", "female panicle length", "male panicle length", "main stem width", "male floret color", "male panicle type", "plant height", "seed on panicle", "seed shatter", "all"), col=c("black", "red", "salmon", "orange", "yellow", "green", "darkgreen", "mediumblue", "purple", "darkmagenta", "maroon", "grey"), pch=16, ncol=3, cex=1.2)
dev.off()

# Save data
save(percentVar, v, x, y, z, file=paste0(today, "_reneth_gbs.Rdata"))