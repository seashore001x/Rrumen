##  An underdevelopment library ggvegan must be install before running this function. 
##  To do this, install devtools from CRAN via running the following command
##  install.packages("devtools")
##  devtools::install_github("gavinsimpson/ggvegan")

##   x  Community data matrix
##   y  Constraining matrix, typically environmental variables
##   group  a taxon vector
##   method   choose RDA or CCA as a calculation method
##   pointsize  size of community data points
##   title  a string for plot title


gvegan <- function(x, y, group, scale = F, method = 'RDA', pointsize = 2.5, title = NULL){
  library('ggplot2')
  library('vegan')
  library('ggvegan')
  
  # RDA&CCA calculation
  if (method = 'RDA'){
    data_rda = rda(x = x, y = y, scale = scale)
  }else if(method = 'CCA'){
    data_rda = cca(x = x, y = y, scale = scale)
  }else{
    return('Wrong method')
  }
  
  # Convert vegan data into ggplot recgoinzed format
  fdata = fortify(data_rda)
  fdata_point = fdata[fdata$Score == 'sites', ]
  fdata_point_x = fdata[fdata$Score == 'sites', 1]
  fdata_point_y = fdata[fdata$Score == 'sites', 2]
  
  # RDA&CCA ploting
  ggplot() +
    
    # add community data points into first layer
    geom_point(data = fdata_point,
               aes(x = fdata_point_x,
                   y = fdata_point_y,
                   fill = group),
               shape = 21,
               size = pointsize,
               color = 'grey') +
    
    # add constraining data with arrows
    geom_segment(data = fdata[fdata$Score == 'biplot',],
                 aes(x = rep(0, length(Dim1)),
                     y = rep(0, length(Dim2)),
                     xend = Dim1,
                     yend = Dim2),
                 arrow = arrow(length = unit(0.02, "npc")),
                 color = 'blue') +
    
    # add community data with arrows
    geom_segment(data = fdata[fdata$Score == 'species',],
                 aes(x = rep(0, length(Dim1)),
                     y = rep(0, length(Dim2)),
                     xend = Dim1,
                     yend = Dim2),
                 arrow = arrow(length = unit(0.02, "npc")),
                 color = 'black') +
    
    # add annotation to constraining data
    geom_text(data = fdata[fdata$Score == 'biplot',],
              aes(x = Dim1 * 1.5,
                  y = Dim2 * 1.5,
                  label = Label)) +
    
    # add annotation to community data
    geom_text(data = fdata[fdata$Score == 'species',],
              aes(x = Dim1 * 1.5,
                  y = Dim2 * 1.5,
                  label = Label)) +
    
    # use ellipse to seperate different groups with 95% confidance
    stat_ellipse(data = fdata_point,
                 aes(x = fdata_point_x,
                     y = fdata_point_y,
                     color = group)) +
    
    # modify labs and title
    xlab(paste('RDA1 (', summary(data_rda)$concont$importance[2,1]*100, '% explained var.)', sep = '')) +
    ylab(paste('RDA2 (', summary(data_rda)$concont$importance[2,2]*100, '% explained var.)', sep = '')) +
    ggtitle(title) +
    
    # legend modification
    theme_bw() +
    theme(plot.title = element_text(face = 'bold'),
          legend.background = element_rect(fill="gray95",
                                           size=.5,
                                           linetype="dotted"))
}


