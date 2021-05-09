# Covid-19-genetic-analysis


# Polygenic risk score calculation 

Softwares: ./plink --version (PLINK v1.90b6.21 64-bit (19 Oct 2020))

Input data: Base data (GWAS summary stats file) This file contains the information about variants, their effect size (given either as beta or OR), chromosomal location, p value, error, etc. Target data (in plink binary formats: .bed, .bim, .fam, .cov (covariates file), .pheno (phenotype file))


	cd plink_mac_20201019

	./plink --vcf filename.vcf --make-bed --double-id --out output_filename

				Output: 

				 output_filename.bed
				 output_filename.bim
				 output_filename.fam
				 output_filename.log
				 output_filename.nosex and more


 	./plink --bfile output_filename --clump-p1 1  --clump-r2 0.1  --clump-kb 250  --clump top100_inIGV  --clump-snp-field SNP --clump-field P --out IGV


 	awk 'NR!=1{print $3}' IGV.clumped >  IGV.valid.snp


	./plink --bfile output_filename --score summary_stats_filename 1 2 3 --extract IGV.valid.snp   --out out_file

				1,2,3 : refers to the column containing SNPs ID, effect size, effective allele information

				Output: 

				out_file.profile (result file)
				out_file.log
				out_file.nopred (contains info about missed variants) and more

	head out_file.nopred

	awk 'NR>1{print $2}' out_file.nopred > snps_to_flip

	./plink --bfile output_filename --score summary_stats_filename 1 2 3 --flip snps_to_flip --out final_out

Detailed description : https://choishingwan.github.io/PRS-Tutorial/plink/   https://zzz.bwh.harvard.edu/plink/dataman.shtml

# Data visualization with R
	BiocManager::install("package_name")
	library(ggplot2)
	library(dplyr)
	library(qqman)
	library(ggpubr)

	setwd("/working/director")

	prs <- read.csv("PRS.csv", sep = ",")
	head(prs)
	
	
Calculating median PRS for each population

	prs_data <- prs %>%
	 group_by(POP) %>%
	 summarise(median(SCORE))

	write.csv(prs_data, file = "prs_data.csv") #to save prs_data file

	

Scatter plot and box plot

	ggscatter(data_filename,x="mean.SCORE.", y="log.deaths.", add="reg.line",conf.int=T, cor.coef=T, cor.method = "spearman", ylab = "No.of deaths due to COVID", xlab = "name", title = "Spearman correlation")
	
	graph <- ggplot(prs, aes(x= POP, y=SCORE)) + geom_boxplot() + theme(axis.text.x = element_text(angle=90,vjust = 0.7), plot.title = element_text (hjust = 0.5))+ geom_jitter(width=0.2,alpha=0.4) + ggtitle("Distribution of PRS scores")+xlab("Populations")+ylab("Polygenic risk score")


qq plots 

	ggqqplot(data_filename$column_which_data_needstobeanalysed)

	shapiro.test(data_filename$column_which_data_needstobe_analysed)


Manhattan plot

	dat <- read.csv("infile.csv", sep = "\t")
	manhattan(dat, chr = "chr", snp = "SNP", p = "P", bp = "pos", col = c("red","green","blue"))

 
Histogram

	neg_control <- read.csv("nc.csv", sep = ",")
	head(neg_control)
	hist(neg_control$pval, xlab = "p values")


