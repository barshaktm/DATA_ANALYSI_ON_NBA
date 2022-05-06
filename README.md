---
title: "NBA Reproducible Data Analysis Project"
output: html_document
---

## Background

In this project I am working as a data analyst with the Chicago Bulls competing in National Basketball Association. This team's budget for player contracts next season is $118 million. So the major purpose behind this data analysis is to find the best five starting players (one from each position) that the Chicago team can buy for the next season. We have to find the best five players making sure that the estimated budget is not just used for the 5 player because we still need to fill a full team roster, so have to just focus on finding five starting players here. I am allowed to choose the players that were already playing for Chicago Bulls in 2018-19, but just need to prove that they are worth it.

This reproducible data analysis on NBA will help the Chicago Bulls in finding good quality players with good points with deserving salary for the next season to help improve the team. The matrices I will use to evaluate the players by looking at the performances of the players from the available dataset. I will be evaluating the players on the basis of certain criteria mentioned below in the data modelling results and players recommendation part.The importance of this data analysis in finding the best five starting players is to make a good players team through which a team can focus on achieving a common goal. A good starting players can always focus on attracting defenders towards him and then they will always try to pass the ball to the open teammate.And the good players will always leads to the wins.Thus it is important to find the best starting players for NBA next season to better the performance of the whole team and to gain the success. 

## Description of the datasets

2018-19_nba_player-statistics.csv : The variables consists of:
player_name : Player Name
Pos :  (PG = point guard, SG = shooting guard, SF = small forward, PF = power forward, C = center) 
Age : Age of Player at the start of February 1st of that season.
Tm : Team
G : Games
GS : Games Started
MP : Minutes Played
FG : Field Goals
FGA : Field Goal Attempts
FG% : Field Goal Percentage
3P : 3-Point Field Goals
3PA : 3-Point Field Goal Attempts
3P% : FG% on 3-Pt FGAs
2P : 2-Point Field Goals
2PA : 2-point Field Goal Attempts
2P% : FG% on 2-Pt FGAs
eFG% : Effective Field Goal Percentage
FT : Free Throws
FTA : Free Throw Attempts
FT% : Free Throw Percentage
ORB : Offensive Rebounds
DRB : Defensive Rebounds
TRB : Total Rebounds
AST : Assists
STL : Steals
BLK : Blocks
TOV : Turnovers
PF : Personal Fouls
PTS : Points

2018-19_nba_player-salaries.csv: The variables consists of:
player_id : unique player identification number
player_name : player name
salary : year salary in $USD

## Contents 

In this project we can find the following contents:
**Introduction about the National Baketball Association(NBA)** : which contains the relevant background information and justification for the project, including: relevant background information of basketball, including key metrics, position requirements etc, description of the scenario,the aim of the project and justification and importance.
**Reading and cleaning the data** : which contains the process to read and clean data.Exploratory analysis: which will include checking the errors, missing values, dealing with the missing values, cleaning the duplicates, checking the relationship between the variables and the interpretation for decisions made about data modelling.
**Data modelling and results** :which contains data modelling using multiple linear regression,assumption checking and moel output and interpretation.
**Player recommendations** : which contains criteria setting for the analysis of the best five starting players for basketball, find the best five players and interpretation of the results. 
**Summary**: which contains a brief summary about the project from the starting to the end and discussion about the findings and results.
