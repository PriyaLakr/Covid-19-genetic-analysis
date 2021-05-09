## to install any package 
BiocManager::install("dplyr")


## load packages 
library(ggplot2)
library(dplyr)
library(qqman)
library(ggpubr)

## set workding dir
setwd("/working/director")


prs <- read.csv("PRS.csv", sep = ",")

## check your data 
head(prs)
dim(prs)

## calculating median polygenic risk score for each population
prs_data <- prs %>%
 group_by(POP) %>%
 summarise(median(SCORE))

write.csv(prs_data, file = "prs_data.csv") 


## Different plots: Scatter plot and box plot

ggscatter(data_filename,x="mean.SCORE.", y="log.deaths.", add="reg.line",conf.int=T, cor.coef=T, cor.method = "spearman", ylab = "No.of deaths due to COVID", xlab = "name", title = "Spearman correlation")
graph <- ggplot(prs, aes(x= POP, y=SCORE)) + geom_boxplot() + theme(axis.text.x = element_text(angle=90,vjust = 0.7), plot.title = element_text (hjust = 0.5))+ geom_jitter(width=0.2,alpha=0.4) + ggtitle("Distribution of PRS scores")+xlab("Populations")+ylab("Polygenic risk score")


## QQ plots and shapiro test for understanding distribution of your data

ggqqplot(data_filename$column_which_data_needstobeanalysed)
shapiro.test(data_filename$column_which_data_needstobe_analysed)

## manhattan plot ; code for this in python by me is a bit faster!  

dat <- read.csv("infile.csv", sep = "\t")
manhattan(dat, chr = "chr", snp = "SNP", p = "P", bp = "pos", col = c("red","green","blue"))

## histogram 

neg_control <- read.csv("nc.csv", sep = ",")
head(neg_control)
hist(neg_control$pval, xlab = "p values")


