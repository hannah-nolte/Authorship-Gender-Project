#Data-Driven Design Project 
#4/12/2021 


#load relevant libraries 
library(dplyr)
library(tidyverse)
library(ggplot2)
library(matrixStats)

setwd("~/Graduate school/Course Work/Data-Driven Design (Spring 2021)/Project")
file <- read.csv("EstimatedDemoDataFullLong.csv")
LG<-read.csv("Hannah_GenderScores_and_LIWC.csv")

file_nation <- file[, c(1, 20)]
names(file_nation)[1] <- "ID"
nation_wide <- file_nation%>%group_by(ID)%>%mutate(id2=1:n())%>%spread(id2,country_id)
names(nation_wide)[1] <- "ID2"

file_age <- file[, c(1, 24)]
names(file_age)[1] <- "ID"
age_wide <- file_age%>%group_by(ID)%>%mutate(id2=1:n())%>%spread(id2,age)
names(age_wide)[1] <- "ID3"

Fuller <- merge(x = LG, y = nation_wide, by.x = c("ID"), by.y = c("ID2"), all.x = TRUE)
Complete<-merge(x = Fuller, y = age_wide, by.x = c("ID"), by.y = c("ID3"), all.x = TRUE)

#write.csv(Complete, 'FullData.csv')

par(mar=c(17,4,4,1))
boxplot(Complete$rep_score~Complete$discipline, xlab= "", las=3, ylab= "Rep Score")

#Stats 
mean(Complete$rep_score)
sd(Complete$rep_score)
ggplot(Complete, aes(y=discipline, x= rep_score))+geom_boxplot()+theme_classic()+xlab("Discipline")+ylab("Representation Score")
ggplot(Complete, aes(y=discipline, x= rep_score))+geom_point(position="jitter", color="gray")+geom_boxplot(outlier.shape = NA)+theme_classic()+ylab("Discipline")+xlab("Representation Score")

Uni_country <- (apply(Complete[493:684], 1, function(x)length(unique(x)))-1)
Not<-(192-rowSums(is.na(Complete[493:684])))
Nation<-Uni_country/Not
ggplot(Complete, aes(y=discipline, x= Nation))+geom_point(position="jitter", color="gray")+geom_boxplot(outlier.shape = NA)+theme_classic()+ylab("Discipline")+xlab("Percentage of Unique Country Codes")
mean(Nation, na.rm=TRUE)
sd(Nation, na.rm=TRUE)

age<-subset(Complete, select = 685:876)
A<-as.matrix(age)
R<-rowRanges(A, na.rm = TRUE, dims = 1, n = NULL)
Age.range<-(R[,2]-R[,1])
ggplot(Complete, aes(y=discipline, x= Age.range))+geom_point(position="jitter", color="gray")+geom_boxplot(outlier.shape = NA)+theme_classic()+ylab("Discipline")+xlab("Age Range")
Age.range[Age.range==-Inf] <- NA
mean(Age.range, na.rm=TRUE)
sd(Age.range, na.rm=TRUE)

Age.average<-rowMeans(A, na.rm=TRUE)
ggplot(Complete, aes(y=discipline, x= Age.average))+geom_point(position="jitter", color="gray")+geom_boxplot(outlier.shape = NA)+theme_classic()+ylab("Discipline")+xlab("Average Age")
mean(Age.average, na.rm=TRUE)
sd(Age.average, na.rm=TRUE)
