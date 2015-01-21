library('reshape') # For Windows errors
library('scales') # For alpha transparency levels in ggplot's element_rect
source('2014 Staff Survey data cleanup.R')

my_theme <- theme(
  plot.background = element_rect(fill='transparent', color=NA),
  panel.grid.major = element_blank(), # element_line(color='black', size=0.1)
  legend.background = element_rect(fill=alpha('black', 0.2), color=NA)
)

# Heat map
png('Plots/Heat map.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(ss2014_combined, type="heat", low.color='#f7f7f7', high.color=muted('blue'), wrap=40, text.size=3) + my_theme
dev.off()

# Combined, ordered
png('Plots/All Bar NoGroup Ordered.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(ss2014_combined, type="bar", low.color="#ca0020", high.color="#0571b0",
       neutral.color="white", neutral.color.ramp="white") + my_theme
  
dev.off()

# Combined bar, each question individually
for (i in c(3:13, 22)) {
  fn <- paste('Plots/Q', i, ' Bar NoGroup.png', sep='')
  png(fn, width=22.9, height=3.87, unit='cm', res=300, type='cairo', bg='transparent')
  
  lkt <- likert(clean_data[i])
  plt <- plot(lkt, type='bar', low.color="#ca0020", high.color="#0571b0",
              neutral.color="white", neutral.color.ramp="white", wrap=15,
              legend.position='none') + my_theme
  print(plt)
  
  dev.off()
}

# Split bar, each question individually
for (i in c(3:13, 22)) {
  fn <- paste('Plots/Q', i, ' Bar Grouped.png', sep='')
  png(fn, width=22.9, height=7.74, unit='cm', res=300, type='cairo', bg='transparent')
  
  lkt <- likert(clean_data[i], grouping=clean_data[[2]])
  plt <- plot(lkt, type='bar', low.color="#ca0020", high.color="#0571b0",
              neutral.color="white", neutral.color.ramp="white", wrap.grouping=15) + my_theme
  print(plt)
  
  dev.off()
}

# Combined density, seperate
png('Plots/All Density NoGroup Facet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(ss2014_combined, type="density") + my_theme
dev.off()

# Combined density, on top of each other
png('Plots/All Density NoGroup NoFacet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(ss2014_combined, type="density", facet=FALSE) +
  theme(legend.position='none') +
  my_theme
dev.off()

# Split density, each question individually, groups of 3
# (I wish I could use loops in R...)
lkt1 <- likert(clean_data[3:5], grouping=clean_data[[2]])
lkt2 <- likert(clean_data[6:8], grouping=clean_data[[2]])
lkt3 <- likert(clean_data[9:11], grouping=clean_data[[2]])
lkt4 <- likert(clean_data[c(12, 13, 22)], grouping=clean_data[[2]])

png('Plots/Q3-4-5 Density Grouped Facet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(lkt1, type='density', low.color="#ca0020", high.color="#0571b0",
              neutral.color="white", neutral.color.ramp="white") + my_theme
dev.off()

png('Plots/Q6-7-8 Density Grouped Facet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(lkt2, type='density', low.color="#ca0020", high.color="#0571b0",
            neutral.color="white", neutral.color.ramp="white") + my_theme
dev.off()

png('Plots/Q9-10-11 Density Grouped Facet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(lkt3, type='density', low.color="#ca0020", high.color="#0571b0",
            neutral.color="white", neutral.color.ramp="white") + my_theme
dev.off()

png('Plots/Q12-13-22 Density Grouped Facet.png', width=22.9, height=11.61, unit='cm', res=300, type='cairo', bg='transparent')
  plot(lkt4, type='density', low.color="#ca0020", high.color="#0571b0",
            neutral.color="white", neutral.color.ramp="white") + my_theme
dev.off()
