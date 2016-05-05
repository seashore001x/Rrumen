# Rrumen

@[R language|Data visualization|Data processing|Rumen microbiota]

## Introduction

**Rrumen** is a collection of R functions for rumen microbial data analysis. These functions are still under development and may not suitable for daily use.

- **summarySE**: Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%)
- **gerrorbar**: Errorbar plotting using ggplot2 graphic system
- **gRDAplot**: Redundancy analysis ploting using ggplot2 graphic system
- **calcSampleSizeForRCT**: Calculating the power of a randomised control trial
- **calcPowerForRCT**: Calculate the number of sampe size for randomized control trial

## Usage
```r
summarySE (data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95, .drop=TRUE)
```
```r
gerrorbar (data, xvars, yvars, se, group, smoothline = F, pd = 0.5, errorbarwidth = 0.5, pointsize = 3, linesize = 1.3, ylimits = NULL, legendlabels = NULL, legendnames = NULL,  xlab = NULL, ylab = NULL, title = NULL, legendjustification = c(1,0), legendposition = c(1,0))
```
```r
gRDAplot (x, y, group, scale = F, method = 'RDA', pointsize = 2.5, title = NULL)
```
```r
calcSampleSizeForRCT (alpha, gamma, piT, piC, p=0)
```
```r
calcPowerForRCT (alpha, piT, piC, n)
```
## Example
- **gerrorbar**
![gerrorbar](https://raw.githubusercontent.com/seashore001x/MarkdownPic/master/sb_plot.png)
- **gRDAplot**
![gRDAplot] (https://raw.githubusercontent.com/seashore001x/MarkdownPic/master/RDA_ggplot.png)
