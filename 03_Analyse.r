#Size of the plots
options(repr.plot.width=16, repr.plot.height=8)

#Theme of the visualisations
theme = theme(plot.title = element_text(size=20, face='bold', hjust = .5),
              plot.subtitle = element_text(20),
              axis.text = element_text(size=20),
              axis.title = element_text(size=20),
              legend.text = element_text(size=20),
              legend.title = element_text(size=20))

grid_theme = theme(plot.title = element_text(size=15, face='bold', hjust = .5),
              plot.subtitle = element_text(15),
              axis.text = element_text(size=15),
              axis.title = element_text(size=15),
              legend.text = element_text(size=15),
              legend.title = element_text(size=15))

#Theme for the pie chart visualisation
pie_theme = theme_classic() + theme(axis.line = element_blank(),
                                    axis.text = element_blank(),
                                    axis.title = element_blank(),
                                    axis.ticks = element_blank(),
                                    plot.title = element_text(size=15, face='bold', hjust = 0.5), 
                                    legend.title = element_text(size=20),
                                    legend.text = element_text(size=20))


#Using four different colours, we can use this function to call them for the visualisation
colors = function(green, navy, yellow, red){
  colors = c(rep('#58735A', green), rep('#64758C', navy), rep('#F29F05', yellow), rep('#DB4437', red))
  return(colors)}
#First create a temp dataframe to calculate the percentage of members and casuals
temp = bikedata_2024_clean %>% 
  group_by(member_casual) %>% 
  summarise(count = n())
  percentiles = geom_text(aes(label = paste0(round(count*100/sum(count),0), "%")), size=5, position = position_stack(vjust = 0.5))


#We will use a pie chart to see the percentage of the whole
ggplot(temp, aes(x='', y=count, fill=member_casual)) + 
  geom_bar(stat="identity", width=1, color='black') +
  coord_polar("y", start=0) +
  percentiles + 
  pie_theme +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1)) +
  labs(title = "2024 User Distribution")
