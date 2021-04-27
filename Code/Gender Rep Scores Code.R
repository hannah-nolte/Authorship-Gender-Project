library(dplyr)
library(tidyverse)

file <- read.csv("EstimatedDemoDataFullLong.csv")

#GET PROBABILITIES

probs <- file[, c(1, 8)]
names(probs)[1] <- "ID"

#CONVERT PROBABILITIES TO WIDE

probs_wide <- probs%>%group_by(ID)%>%mutate(id2=1:n())%>%spread(id2,probability.gender)

#GET AVG PROBABILITY FOR EACH PAPER

probs_wide$avg_prob <- round(rowMeans(cbind(probs_wide[, 2:9]),na.rm=T), 2)

#REMOVE PAPERS WITH AVG PROB LESS THAN 0.85 

probs_final <- subset(probs_wide, probs_wide$avg_prob >= 0.85)

#GET GENDERS AND CODE

file_gender <- file[, c(1, 7)]
names(file_gender)[1] <- "ID"
file_gender$gender[file_gender$gender == "male"] <- 0
file_gender$gender[file_gender$gender == "female"] <- 1

#CONVERT GENDERS TO WIDE

gender_wide <- file_gender%>%group_by(ID)%>%mutate(id2=1:n())%>%spread(id2,gender)
names(gender_wide)[1] <- "ID1"

#GET ONLY THE NEEDED COLUMNS FROM PROBS_FINAL

probs_merge <- probs_final[, c(1,10)]

#GET GENDERS ONLY FOR PAPERS WUITH AVG PROB >= 0.85

final_dataset <- merge(x = probs_merge, y = gender_wide, by.x = c("ID"), by.y = c("ID1"), all.x = TRUE)

#CONVERT TO NUMERIC SO THAT WE CAN GET SUMS

final_dataset <- as.data.frame(apply(final_dataset, 2, as.numeric))

#FIND GENDER REPRESENTATION SCORE

final_dataset$sum <- rowSums(cbind(final_dataset[, 3:192]),na.rm=T)
final_dataset$teamsize <- rowSums( !is.na(final_dataset[, 3:192]))
final_dataset$rep_score <- round(final_dataset$sum/final_dataset$teamsize, 2)

#GET LIWC SHEET

liwc <- read.csv("ProjectData2006-2012.csv")
names(liwc)[1] <- "ID1"

#GET LIWC DATA ONLY FOR THE NEEDED PAPERS AND REMOVE COLUMNS WITH NAMES SINCE WE DONT NEED THEM ANYMORE

liwc_and_gender <- merge(x = final_dataset, y = liwc, by.x = c("ID"), by.y = c("ID1"), all.x = TRUE)

#write.csv(liwc_and_gender, "D:/PhD Courses/Semester 4/Data Driven Design/Project/REVISED_GenderScores_and_LIWC.csv")
