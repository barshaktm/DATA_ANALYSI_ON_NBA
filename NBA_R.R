#loading necessary packages
library(tidyverse)
library(readr)
library(ggplot2)
library(ggcorrplot)
library(reshape2)
library(broom)


#Reading Data

#Here we are using read_csv from readr package to import .csv files into 
#our working directory.

#The data used in this document contains two datasets of National Basketball 
#Association(NBA) and they are total statistics for individual NBA players 
#during the 2018-19 season and the salary for individual players during the 
#2018-19 NBA season. We are using the data which has been sourced from: 
#2018-19_nba_player-statistics.csv :  sourced from basketball-reference.com  
#2018-19_nba_player-salaries.csv :  sourced from hoopshype.com/salaries


salaries <- read_csv("2018-19_nba_player-salaries.csv")
statistics <- read_csv("2018-19_nba_player-statistics.csv")


#Data Preprocessing

#using relevant function to check the structure of chosen datasets
str(salaries)
str(statistics)

#using relevabt function to check the first 6 and last 6 rows of the chosen datasets
head(salaries)
head(statistics)

tail(salaries)
tail(statistics)

#Checking missing values and cleaning the chosen datasets

sum(is.na(salaries))
sum(is.na(statistics))

#There is no missing values on salaries datasets 
#but there is 117 missing values in statistics datasets

#visualising missing values of statistics datasets
naniar::vis_miss(statistics)

#looking at the graph we can interpret that the columns having
#a missing values are 3P(6.64%), 2P(2.12)%, and FT(6.07)%
#There are just 0.6% of missing values in whole datasets which are very less 
#so we will clean the datasets and make it ready for analysis by dropping missing values
#we will stored the cleaned datasets in player_statistics 

player_statistics <- drop_na(statistics)

sum(is.na(player_statistics))

#Thus there is no missing values in the player_statistics dataset


#Merging datasets

#merging salaries dataset and players statistics data sets together by using merge() function

merged_data <- merge(salaries, player_statistics, by = "player_name", all = TRUE)

#checking the missing values of merged dataset

sum(is.na(merged_data))

#dropping the missing values

merged_data <- drop_na(merged_data)

#Removing duplicates 

#we can see many duplicates in the merged datasets so 
#removing all those duplicates using duplicated function

players_cleaned_data <- merged_data[!duplicated(merged_data$player_name, merged_data$player_id), ] 


#saving cleaned data
write.csv(players_cleaned_data, "cleaned_data.csv")

#Exploratory Data Analysis

#what is the salary distribuition of the players?

#Salary distribuition using histogram
ggplot(players_cleaned_data, aes(x = salary)) +                        
  geom_histogram(col = "black", fill = "tomato4")+
  xlab("Salary")+
  ggtitle("Salary Distribution")


#From the plot we can interpret that the salary distribution of the players
#are positively skewed towards right and there are very few players whose earnings
#is more than a million and most of the players salary is less than a million.

#what is the age distribution of the players?

#Age distribution using histogram

ggplot(players_cleaned_data, aes(Age)) + 
  geom_histogram(col = "black", fill = "blue")+
  xlab("Age")+
  ggtitle("Age Distribution")


#from the plot we can interpret that the age distribution of the payers is between 20-40 years
#most of the players age group is 20-30
#very less players are above 35+ age

#How is age and salary of players related to each other?

#Displaying the relationship between Age and Salary  
ggplot(players_cleaned_data, aes(Age, salary)) + 
    geom_point(aes(colour = factor(Age)))


#from the plot we can interpret that the players who are at their early 20s earns less
#salary comparing to the earnings of the players who are at the age of 25-35.
#There are very less players at the age of 40 and ears less aswell
 
#how does players positions and  points affects the players earning?

ggplot(data = players_cleaned_data, aes(x= Pos, y = salary, color= Pos))+
  geom_boxplot()+
  theme_classic()


#from the barplot we can clearly visualise that players having a positions like 
#Center (C),power forward (PF),Point guard (PG), Shooting guard (SG) 
#and small Forward earns more than others.
#we can also interpret that the relationship between POS and salary has positively 
#skewed towards right.

ggplot(data = players_cleaned_data, aes(x = PTS, y = salary, color = Pos)) +
  geom_point()+
  ggtitle("Relationship between player points and salary")


#from the plot we can interpret that the player points and salary has a positive 
#relationship with each other. The increase in players points will increase the
#players salary and vice-versa.

#Does the minutes played by a players influence players points?

ggplot(data = players_cleaned_data, aes(x = MP, y = PTS)) +
  geom_point() +
  ggtitle("Relationship between minutes played and points") +geom_smooth(method = lm)


#Looking at the plot we can interpret that the more minutes given to the players to play 
#will help increasing in players points. Therefore there is a positive relationship between 
#minutes played and players points.


#Correlation Heatmap

#Now checking the relationship between all numeric variables, therefore removing non-numeric
#variables from the players_cleaned dataset

numeric_variables <- select(players_cleaned_data,-c(player_name, Pos, Tm))


round(x = cor(numeric_variables), digits = 2)

ggcorrplot(cor(numeric_variables)) +
  ggtitle("Correlation Heatmap")


#from the correlation heatmap we can clearly identify the relationship between 
#the variables. Lighter color in the heatmap represents weak relationship among variables
#and darker color in the heatmap represents strong relationship among variables.

#Data modelling and Results

#In this part we have to select the variables to be used for the modelling the data
# We are conducting the linear regression model players Points (PTS) based on Position,
#AGE, games, games started, minutes played, field goals, field goals attempts, free throws, 
#free throws attempts, defensive rebounds, total rebounds, turnovers


fit <- lm(PTS~ Pos+ Age+ G+ GS+ MP+ FG+ FGA+ FT+ FTA+ DRB+ TRB+ TOV, data = players_cleaned_data)
tidy(fit, conf.int = TRUE)
summary(fit)

#looking at the summary of this model we can interpret that AGE, minutes played, field goals, 
#field goals attempts, free throws,and defensive rebounds will contribute
#to a player having a higher points. 
#The r-squared values is 0.9977 thus we can say that the players can have high points
#if the player has a better statistics.

#Now we will just deal with this variables: Salary, Players_name, PTS, Pos, MP, GS

new_data <- select(players_cleaned_data, c(salary, player_name, PTS,Pos, MP, G))

#arranging the players point from highest to lowest

high_low_data <- new_data%>%
  arrange(desc(PTS))

#checking the summary of PTS, salary, MP and G

summary(high_low_data$PTS)
summary(high_low_data$salary)
summary(high_low_data$MP)
summary(high_low_data$G)

#Here we are finding the top five players by positions using filter function. 
#We will set the criteria being based on the summary of the chosen variables 
#printed above. In most of the criteria we will take median values and maximum values from the summary of the 
#chosen variables and we will filter the data accordingly which will help us 
#finding the top five starting players by positions.

#Criteria are as follows:
#minimum of 421 points achieved
#salary should be between 3 million to 20 million
#minimum of 1071 minutes should be played
#minumum of 54 games played


#Point_Guard 

position_PG <- high_low_data %>%
  filter(Pos == "PG") %>% 
  filter(G >=54, 
         MP>=1071, 
         salary>=3258539, 
         salary<= 20000000, 
         PTS>=421)

position_PG

#Shooting_Guard

position_SG <- high_low_data %>%
  filter(Pos == "SG") %>% 
  filter(G >=54, 
         MP>=1071, 
         salary>=3258539, 
         salary<=20000000, 
         PTS>=421)

position_SG

#Small Forward

position_SF <- high_low_data %>%
  filter(Pos == "SF") %>% 
  filter(G >=54, 
         MP>=1071, 
         salary>=3258539, 
         salary<=20000000, 
         PTS>=421)

position_SF

#Power Forward

position_PF <- high_low_data %>%
  filter(Pos == "PF") %>% 
  filter(G >=54, 
         MP>=1071, 
         salary>=3258539, 
         salary<=20000000, 
         PTS>=421)

position_PF

#centre

position_C <- high_low_data %>%
  filter(Pos == "C") %>% 
  filter(G >=54, 
         MP>=1071, 
         salary>=3258539, 
         salary<=20000000, 
         PTS>=421)

position_C

#Therefore the top five starting players recommendation to Chicago Bulls
#from different positions are:

top_five_players <- list(
  point_guard =  position_PG[1,],
  shooting_guard =  position_SG[1,],
  small_forward = position_SF[1,],
  power_forward = position_PF[1,],
  centre =  position_C[1,])

top_five_players

#Adding the total salary of top five recommended players

sum_of_top_five_players_salary <- sum(position_PG$salary[1],
    position_SG$salary[1],
    position_SF$salary[1],
    position_PF$salary[1],
    position_C$salary[1])

print(sum_of_top_five_players_salary)     

#The summation of total salary of the recommended top five 
#starting players is 48453800 which is less than the estimated budget
#of 118000000.Being the starting players the salary for them will be 
#high comparing to the other players. So the remaining budget can be 
#used to full the team roster. I think these recommended players can 
#be the best starting players who will be quality players and improves
#the team for the upcoming season.



