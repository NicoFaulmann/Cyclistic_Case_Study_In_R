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

#Change the temp dataframe to calculate how many users (member, casual) use a specific bike type
temp = bikedata_2024_clean %>%
  group_by(member_casual, rideable_type) %>%
  summarise(.groups = 'drop', count=n()) 

#We use a column chart to show totals between the users of each type of bike
ggplot(temp, aes(fill=member_casual, x=rideable_type, y=count)) +
  geom_col(position='dodge', color='black') +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1)) +
  theme + 
  ggtitle('User Bike Preference') + 
  xlab('Bike Type') + 
  scale_y_continuous(name='Trip Amount', labels = comma)

#Calculate bike demand over the course of a week

#First lets order the days of the week so that the graph makes sense
ordered_days = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
bikedata_2024_clean$day_of_week = ordered(bikedata_2024_clean$day_of_week, levels=ordered_days)

#Now change the temp to display the users over the day of the week
temp = bikedata_2024_clean %>% 
  group_by(member_casual, day_of_week) %>%
  summarise(.groups='drop', count=n())

#Use a bar chart as we have multiple y-values (weekdays)
ggplot(temp, aes(fill=member_casual, x=count, y=day_of_week, width=.6)) + 
  geom_col(position='dodge', color='black') +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1)) + 
  theme + 
  theme(axis.title.y = element_blank()) + 
  ggtitle('Bike Demand over Weekdays') + 
  scale_x_continuous(name='Trip Amount', labels=comma)

#Next lets calculate what stations are popular per user type

#First store values of start and end station totals per user type
start1 = bikedata_2024_clean %>% 
  filter(start_station_name!='') %>% 
  filter(member_casual=='member') %>%
  group_by(start_station_name) %>%
  summarise(count=n()) %>%
  arrange(-count) %>%
  head(10)


end1 = bikedata_2024_clean %>%
  filter(end_station_name!='') %>% 
  filter(member_casual=='member') %>%
  group_by(end_station_name) %>%
  summarise(count=n()) %>%
  arrange(-count) %>%
  head(10)

start2 = bikedata_2024_clean %>%
  filter(start_station_name!='') %>% 
  filter(member_casual=='casual') %>%
  group_by(start_station_name) %>%
  summarise(count=n()) %>%
  arrange(-count) %>%
  head(10)

end2 = bikedata_2024_clean %>%
  filter(end_station_name!='') %>% 
  filter(member_casual=='casual') %>%
  group_by(end_station_name) %>%
  summarise(count=n()) %>%
  arrange(-count) %>%
  head(10)

#Next we can plot the member start and end values into bar charts
Member_StartPop <- ggplot(start1, aes(x=count, y=reorder(start_station_name, count))) + 
  geom_col(color='black', fill=colors(1, 0, 0, 0)) +
  grid_theme + 
  ggtitle('Member Start Station Popularity') + 
  scale_x_continuous(name='Trip Amount', labels=comma) + 
  ylab('Station Address')
  
Member_EndPop <- ggplot(end1, aes(x=count, y=reorder(end_station_name, count))) + 
  geom_col(color='black', fill=colors(0, 1, 0, 0)) +
  grid_theme + 
  ggtitle('Member End Station Popularity') + 
  scale_x_continuous(name='Trip Amount', labels=comma) + 
  theme(axis.title.y=element_blank())

#Then we can do the same for the casual riders
Casual_StartPop <- ggplot(start2, aes(x=count, y=reorder(start_station_name, count))) + 
  geom_col(color='black', fill=colors(0, 0, 1, 0)) +
  grid_theme + 
  ggtitle('Casual Start Station Popularity') + 
  scale_x_continuous(name='Trip Amount', labels=comma) + 
  ylab('Station Address') 
  
Casual_EndPop <- ggplot(end2, aes(x=count, y=reorder(end_station_name, count))) + 
  geom_col(color='black', fill=colors(0, 0, 0, 1)) +
  grid_theme + 
  ggtitle('Casual End Station Popularity') + 
  scale_x_continuous(name='Trip Amount', labels=comma) + 
  theme(axis.title.y=element_blank())

#Finally we can combine these charts into one visualisation so that they are easily comparable
grid.arrange(Member_StartPop, Member_EndPop, Casual_StartPop, Casual_EndPop, ncol = 2)

#Now we want to calculate the average ride time and length of members and casuals

#We will use a boxplot to gain more insight into ride length than just the average
ggplot(bikedata_2024_clean, aes(y=ride_length, x='User Type', fill=member_casual)) +
  geom_boxplot(outlier.shape=NA) +
  scale_y_continuous(name='Mins', breaks=seq(0, 45, 5), limits=c(0, 45)) +
  theme +
  theme(axis.title.x=element_blank()) + 
  ggtitle('User Ride Length (Mins)') +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1))

#Now we want to calculate the average ride time and length of members and casuals

#We will use a boxplot to gain more insight into ride length than just the average
ggplot(bikedata_2024_clean, aes(y=ride_length, x='User Type', fill=member_casual)) +
  geom_boxplot(outlier.shape=NA) +
  scale_y_continuous(name='Mins', breaks=seq(0, 45, 5), limits=c(0, 45)) +
  theme +
  theme(axis.title.x=element_blank()) + 
  ggtitle('User Ride Length (Mins)') +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1))

#Use a boxplot again to gain more insight on the range of distances
ggplot(bikedata_2024_clean, aes(y=ride_distance, x='User Type', fill=member_casual)) +
  geom_boxplot(outlier.shape=NA) +
  scale_y_continuous(name='Km', breaks=seq(0, 10, 1), limits=c(0, 7)) +
  theme +
  theme(axis.title.x=element_blank()) + 
  ggtitle('User Ride Distance (Km)') +
  scale_fill_manual("User Type", values=colors(0, 1, 0, 1))

#We can filter out a summary to double check our findings
paste('Summary of ride length (Members)')
summary(bikedata_2024_clean%>%
            filter(member_casual=='member'))
  
paste('Summary of ride length (Casuals)')
summary(bikedata_2024_clean %>% 
  filter(member_casual=='casual'))

#Now we can calculate the bike demand per user over the year of 2024

#First let's adjust our temp dataframe to show the amount of trips during each month
temp = bikedata_2024_clean %>%
  group_by(member_casual, month) %>%
  summarise(.groups='drop', count = n())

#Then we will use a line chart to show the trend of demand over the year
ggplot(temp, aes(group=member_casual, x=month, y=count)) +
  geom_line(aes(color=member_casual)) + 
  geom_point(aes(color=member_casual)) + 
  theme +
  scale_y_continuous(name='Trip Amount', labels=comma) + 
  scale_color_manual('User Type', values=colors(0, 1, 0, 1)) + 
  ggtitle('Bike Demand Over 2024')

#We can do the same to understand the peak time during the day for bike hires

#Again we first adjust the temp dataframe
temp = bikedata_2024_clean %>%
  group_by(member_casual, time) %>%
  summarise(.groups='drop', count = n())

#Next we use a line chart to show the trend over 24h
ggplot(temp, aes(group=member_casual, x=time, y=count)) +
  geom_line(aes(color=member_casual)) + 
  geom_point(aes(color=member_casual)) + 
  theme +
  xlab('Hour') +
  scale_y_continuous(name='Trip Amount', labels=comma) + 
  scale_color_manual('User Type', values=colors(1, 0, 0, 1)) + 
  ggtitle('Bike Demand Over 24h')
