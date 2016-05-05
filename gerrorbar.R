##  error bar ploting using ggplot2.
##   data: a data frame.
##   xvars: xlab variation vector
##   yvars: ylab variation vector
##   se: standard deviation vector, can be generated from summarySE function
##   group: a vector containing names of colums that contain grouping variables
##   pd: ajust posistion by dodging overlaps to the side
##   errorbarwidth: wideth of errorbars
##   pointsize: size of points
##   linesize: size of lines
##   ylimits: ajust length of y label
##   legendlabes: labels for legend
##   legendnames: title for legend
##   xlab, ylab: change axis labels titles
##   title: add titel to this plot

gerrorbar <- function(data, xvars, yvars, se, group, smoothline = F,
                      pd = 0.5, errorbarwidth = 0.5,
                      pointsize = 3, linesize = 1.3, ylimits = NULL,
                      legendlabels = NULL, legendnames = NULL,
                      xlab = NULL, ylab = NULL, title = NULL,
                      legendjustification = c(1,0), legendposition = c(1,0)){
  
  #load data
  library('ggplot2')
  data$yvars = data[, yvars]
  data$xvars = data[, xvars]
  data$se = data[, se]
  
  #basic plot
  g = ggplot(data, aes(xvars, yvars, group = group, color = group, shape = group))
  
  # poistion_doge
  pd = position_dodge(pd)
  
  # add error bar layer
  g = g + geom_errorbar(position = pd, 
                        aes(ymin = yvars - se,
                            ymax = yvars + se),
                        color = 'black',
                        width = errorbarwidth)
  
  # check whether the linetype is smooth and modifty the line layer
  if(smoothline){
    g = g + geom_smooth(position = pd, se = F, aes(linetype = group), size = linesize)
  }else{
    g = g + geom_line(position = pd, aes(linetype = group), size = linesize) 
  }
  g = g + scale_linetype_manual(values = c('solid', 'longdash'),
                                name = legendnames,
                                labels = legendlabels)
  

  # add and mofity points
  g = g + geom_point(position = pd,
                    fill = 'white',
                    size = pointsize)+
    scale_shape_manual(values = c(21,22),
                       name = legendnames,
                       labels = legendlabels)
  
  # modifty point color
  g = g + scale_color_discrete(l = 40,
                               name = legendnames,
                               labels = legendlabels)
  
  # modifty labs and titles
  g = g + xlab(xlab) + ylab(ylab) + ggtitle(title)+
    scale_x_continuous(breaks=data$xvars)
  
  # legend modification
  g = g + theme_bw() +
    theme(legend.justification= legendjustification,
          legend.position=legendposition,
          plot.title = element_text(face = 'bold'),
          legend.background = element_rect(fill="gray95",
                                           size=.5,
                                           linetype="dotted"))
  
  # ylab expansion
  g = g + expand_limits(y = ylimits)
  
  return (g)
} 

