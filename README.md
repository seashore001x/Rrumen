# Rrumen

@[R language|Data visualization|Data processing|Rumen microbiota]

## Introduction

**Rrumen** is a collection of R functions for rumen microbial data analysis. These functions are still under development and may not suitable for daily use. R environment and extra packages are required for running this functions

- **phyloseq2lefse**: Convert phyloseq object into lefse compatible input file
- **GrubbsFlag**: Flag outliers in a vector using grubbs algorithm
- **summarySE**: Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%)
- **gerrorbar**: Errorbar plotting using ggplot2 graphic system
- **gRDAplot**: Redundancy analysis ploting using ggplot2 graphic system
- **calcSampleSizeForRCT**: Calculating the power of a randomised control trial
- **calcPowerForRCT**: Calculate the number of sampe size for randomized control trial

## Usage
- **phyloseq2lefse**
```r
phyloseq2lefse(physeq)
> ps
phyloseq-class experiment-level object
otu_table()   OTU Table:         [ 4211 taxa and 84 samples ]
sample_data() Sample Data:       [ 84 samples by 5 sample variables ]
tax_table()   Taxonomy Table:    [ 4211 taxa by 6 taxonomic ranks ]
phy_tree()    Phylogenetic Tree: [ 4211 tips and 4198 internal nodes ]
refseq()      DNAStringSet:      [ 4211 reference sequences ]
> phyloseq_to_lefs(ps)
Subject                                                                                "S1" "S2" "S3"     
Time                                                                                   "4"   "4"  "4"   
Treatment                                                                              "AA"  "AA" "AA"          
Bacteria|Chloroflexi|Anaerolineae|Anaerolineales|Anaerolineaceae|Unclassified          "17"  "23" "16"    
Bacteria|Elusimicrobia|Elusimicrobia|Elusimicrobiales|Elusimicrobiaceae|Elusimicrobium " 0"  "3"  "5"  
Bacteria|Elusimicrobia|Endomicrobia|Candidatus_Endomicrobium|Unclassified|Unclassified "16"  "20" "13"    
Bacteria|Spirochaetes|Spirochaetia|Spirochaetales|Spirochaetaceae|Unclassified         "54"  "60" "62"    
...
```
---

- **GrubbsFlag**
```r
GrubbsFlag(vector)
> a = c(1, 2, 3, -20, 100)
> GrubbsFlag(a)
    X Outlier
1   1   FALSE
2   2   FALSE
3   3   FALSE
4 -20    TRUE
5 100    TRUE
```
---

- **summarySE**
```r
summarySE (data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95, .drop=TRUE)

```
Summarizes data.
Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
data: a data frame.
measurevar: the name of a column that contains the variable to be summariezed
groupvars: a vector containing names of columns that contain grouping variables
na.rm: a boolean that indicates whether to ignore NA's
conf.interval: the percent range of the confidence interval (default is 95%)
```r
> head(mtcars)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
> summarySE(mtcars, 'mpg', 'cyl')
  cyl  N      mpg       sd        se       ci
1   4 11 26.66364 4.509828 1.3597642 3.029743
2   6  7 19.74286 1.453567 0.5493967 1.344325
3   8 14 15.10000 2.560048 0.6842016 1.478128
```
---

- **gerrorbar**
```r
gerrorbar (data, xvars, yvars, se, group, smoothline = F, pd = 0.5, errorbarwidth = 0.5, pointsize = 3, linesize = 1.3, ylimits = NULL, legendlabels = NULL, legendnames = NULL,  xlab = NULL, ylab = NULL, title = NULL, legendjustification = c(1,0), legendposition = c(1,0))
```
data: a data frame
xvars: x axis variable
yvars: y asxis variable
se: a vector of standard error of means, can be calculated using `summarySE` function
group: name of grouping variable
pd: position dodge
![gerrorbar](https://github.com/seashore001x/Rrumen/blob/master/MarkdownPic/sb_plot.png)
---

- **gRDAplot**
```r
gRDAplot (x, y, group, scale = F, method = 'RDA', pointsize = 2.5, title = NULL)
```
![gRDAplot](https://github.com/seashore001x/Rrumen/blob/master/MarkdownPic/RDA_ggplot.png)
---

```r
calcSampleSizeForRCT (alpha, gamma, piT, piC, p=0)
```
```r
calcPowerForRCT (alpha, piT, piC, n)
```
```r
paste2(vector)
```


