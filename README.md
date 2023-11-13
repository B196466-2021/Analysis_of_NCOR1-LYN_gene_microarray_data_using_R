# Analysis_of_NCOR1-LYN_gene_microarray_data_using_R

## 1.Introduction
NCOR1-LYN was identified as a novel fusion gene in paediatric acute lymphoblastic leukaemia patients, and leukaemic cells expressing NCOR1-LYN were found to be sensitive to dasatinib in vivo. To reveal which pathways are affected by NCOR1-LYN, this trial used microarrays for gene expression analysis.


## 2.Data
NCOR1-LYN-expressing Ba/F3 cells were created by inducing NCOR1-LYN expression in Ba/F3 cells using a tetracycline-inducible gene expression system. Finally, Ba/F3 cells expressing DOX-induced NCOR1-LYN were grown in triplicate alongside uninduced Ba/F3 cells.

## 3.Quality control
Quality control checks the distribution of expression values to avoid abnormal chips. In the present trial, quality control is performed by examining a a density plot , a boxplot and a MAplot. 

## 4. RMA Normalisation
The unification of data between distinct groups is known as normalisation. This is due to the background correction of the data between groups, which removes part of the noise. However, due to internal or external reasons, it is impossible to eliminate overall variations in a group. If this is not done, it will be impossible to compare groups since general increases and decreases in a group will cause the size relationship between groups to be disrupted.

## 5. Hierarchical clustering of normalised data
Cluster analysis is mainly used to understand unknown functions. By clustering analysis, genes are grouped into categories based on certain characteristics. Genes aggregated into the same type have similar patterns of expression, and they are likely to have some similar functions. The function of other unknown genes can then be further analyzed by understanding the known processes of genes in a particular category. Clustering refers to the grouping of genes according to different functions or the same expression behavior based on gene expression data from gene chips. 

## 6. Principal Components Analysis of normalised data
The principal component analysis method allows visualization of the clustering of samples on the gene microarray, allowing visualization of the distribution of samples between experimental and control groups, thus facilitating the detection and removal of abnormal samples, the presence of which would otherwise adversely affect subsequent analysis such as the identification of differential genes. The purpose of the principal component analysis is to project high-dimensional data into a lower dimensional space. For a complex thing described by several variables, the main aspects of the item are reflected in a few main variables, which are then separated out and analyzed in detail.

## 7 Statistical analysis using Limma
Establish a suitable design matrix first; there are generally multiple equivalent procedures that can be utilized to create an acceptable design matrix for a given experiment. The capacity of the limma linear model technique to tolerate arbitrary levels of experimental complexity is one of its main strengths. The comparison matrix then specifies which sample comparisons should be made. The lmFit and contrasts are then used to carry out the linear modeling of limma. Fit functions, with each gene's expression data being fitted to a different model. Then, using information from the entire gene, an empirical Bayesian correction is conducted, allowing for a more precise estimation of gene variability. After that, a summary table is created. 

## 8. Functional Enrichment Analysis using Limma 
Enrichment analysis refers to statistical analysis with the help of various databases and analytical tools to mine the database for functional categories of genes that have significant relevance to the biological questions we want to study and is a method of differential expression analysis by using the limma package to analyze up-or down-regulation of gene functions and expression pathways.
