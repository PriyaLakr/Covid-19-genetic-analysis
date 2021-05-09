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
	
Codes in scripts folder!!
	
Calculating median PRS for each population!!

Histogram, scatter, box, qq and Manhattan plot

	


