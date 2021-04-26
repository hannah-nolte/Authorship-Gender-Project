#Data-Driven Design Project 
#4/12/2021 
 

#load relevant libraries 
require(DemografixeR)
require(tidyr)

#save_api_key(key='KEY')

#load data
setwd("~/Graduate school/Course Work/Data-Driven Design (Spring 2021)/Project")
data<-read.csv('ProjectData2006-2012.csv', na.strings=c("","NA"))
#add IDs for long format
data$ID <- seq.int(nrow(data))
#subset just the names 
data.names<-subset(data, select = c(name1:name194,ID)  )

#Make a long format
long<-reshape(data.names,direction="long", varying =list(1:194),idvar="ID" )
View(long)
long.small<-long[complete.cases(long), ]

#Make sure it can be reverted to the wide 
wide<-reshape(long.small,direction="wide", idvar="ID" )
View(wide)

#eliminate spaces before and after the names for the API 
long.small$Names<- trimws(long.small$name1, which = c("both"))

#Find the gender
Gender<-genderize(name = long.small$Names, simplify = FALSE, meta = TRUE)

#write gender into a CSV just in case 
#write.csv(Gender, "Gender.csv")

#Find Nationality 
#Rbind error when run in large batches 
#Nation<-nationalize(name = long.small$Names, simplify = FALSE, meta = TRUE)

#run small batches 
#some needed to be run smaller than 10,000
nation<-nationalize(name = long.small$Names[1:10000], simplify = FALSE, meta = TRUE)
nation2<-nationalize(name = long.small$Names[10001:20000], simplify = FALSE, meta = TRUE)
nation3<-nationalize(name = long.small$Names[20001:30000], simplify = FALSE, meta = TRUE)
nation4<-nationalize(name = long.small$Names[30001:40000], simplify = FALSE, meta = TRUE)
nation5<-nationalize(name = long.small$Names[40001:50000], simplify = FALSE, meta = TRUE)
nation6<-nationalize(name = long.small$Names[50001:60000], simplify = FALSE, meta = TRUE)
nation7<-nationalize(name = long.small$Names[60001:70000], simplify = FALSE, meta = TRUE)
nation8<-nationalize(name = long.small$Names[70001:80000], simplify = FALSE, meta = TRUE)
nation9a<-nationalize(name = long.small$Names[80001:85000], simplify = FALSE, meta = TRUE)
nation9b<-nationalize(name = long.small$Names[85001:90000], simplify = FALSE, meta = TRUE) 
nation10<-nationalize(name = long.small$Names[90001:100000], simplify = FALSE, meta = TRUE)
nation11<-nationalize(name = long.small$Names[100001:110000], simplify = FALSE, meta = TRUE)
nation12<-nationalize(name = long.small$Names[110001:120000], simplify = FALSE, meta = TRUE)
nation13a<-nationalize(name = long.small$Names[120001:125000], simplify = FALSE, meta = TRUE)
nation13b<-nationalize(name = long.small$Names[125001:127500], simplify = FALSE, meta = TRUE)
nation13c<-nationalize(name = long.small$Names[127501:130000], simplify = FALSE, meta = TRUE)
nation14<-nationalize(name = long.small$Names[130001:140000], simplify = FALSE, meta = TRUE) 
nation15a<-nationalize(name = long.small$Names[140001:143000], simplify = FALSE, meta = TRUE)
nation15b<-nationalize(name = long.small$Names[143001:150000], simplify = FALSE, meta = TRUE)
nation16<-nationalize(name = long.small$Names[150001:160000], simplify = FALSE, meta = TRUE)
nation17<-nationalize(name = long.small$Names[160001:170000], simplify = FALSE, meta = TRUE)
nation18a<-nationalize(name = long.small$Names[170001:175000], simplify = FALSE, meta = TRUE)
nation18b<-nationalize(name = long.small$Names[175001:180000], simplify = FALSE, meta = TRUE)
nation19<-nationalize(name = long.small$Names[180001:190000], simplify = FALSE, meta = TRUE)
nation20<-nationalize(name = long.small$Names[190001:200000], simplify = FALSE, meta = TRUE)
nation21a<-nationalize(name = long.small$Names[200001:205000], simplify = FALSE, meta = TRUE)
nation21b<-nationalize(name = long.small$Names[205001:208000], simplify = FALSE, meta = TRUE)
nation21c<-nationalize(name = long.small$Names[208001:210000], simplify = FALSE, meta = TRUE)
nation22a<-nationalize(name = long.small$Names[210001:215000], simplify = FALSE, meta = TRUE)
nation22b<-nationalize(name = long.small$Names[215001:220000], simplify = FALSE, meta = TRUE)
nation23<-nationalize(name = long.small$Names[220001:230000], simplify = FALSE, meta = TRUE)
nation24<-nationalize(name = long.small$Names[230001:240000], simplify = FALSE, meta = TRUE)
nation25<-nationalize(name = long.small$Names[240001:250000], simplify = FALSE, meta = TRUE)
nation26<-nationalize(name = long.small$Names[250001:260000], simplify = FALSE, meta = TRUE)
nation27<-nationalize(name = long.small$Names[260001:270000], simplify = FALSE, meta = TRUE)
nation28<-nationalize(name = long.small$Names[270001:280000], simplify = FALSE, meta = TRUE)
nation29<-nationalize(name = long.small$Names[280001:290000], simplify = FALSE, meta = TRUE)
nation30a<-nationalize(name = long.small$Names[290001:293000], simplify = FALSE, meta = TRUE)
nation30b<-nationalize(name = long.small$Names[293001:300000], simplify = FALSE, meta = TRUE)
nation31<-nationalize(name = long.small$Names[300001:310000], simplify = FALSE, meta = TRUE)
nation32<-nationalize(name = long.small$Names[310001:320000], simplify = FALSE, meta = TRUE)
nation33a<-nationalize(name = long.small$Names[320001:325000], simplify = FALSE, meta = TRUE)
nation33b<-nationalize(name = long.small$Names[325001:330000], simplify = FALSE, meta = TRUE)
nation34<-nationalize(name = long.small$Names[330001:340000], simplify = FALSE, meta = TRUE)
nation35<-nationalize(name = long.small$Names[340001:350000], simplify = FALSE, meta = TRUE)
nation36<-nationalize(name = long.small$Names[350001:356412], simplify = FALSE, meta = TRUE)

#combine all the nationality results into one data frame
Nation.total<-rbind(nation, nation2, nation3,nation4, nation5,nation6,nation7,nation8, nation9a, nation9b,
                    nation10, nation11, nation12, nation13a, nation13b, nation13c, nation14, nation15a, nation15b,
                    nation16, nation17, nation18a, nation18b, nation19, nation20, nation21a, nation21b, nation21c,
                    nation22a, nation22b, nation23, nation24, nation25, nation26, nation27, nation28, nation29,
                    nation30a, nation30b, nation31, nation32, nation33a, nation33b, nation34, nation35, nation36)

#Write nationality results to data frame just in case 
#write.csv(Nation.total, "Nation.csv")

#Run age in batches (didn't have to be batches)
Age1<-agify(name = long.small$Names[1:100000], simplify = FALSE, meta = TRUE)
Age2<-agify(name = long.small$Names[100001:200000], simplify = FALSE, meta = TRUE)
Age3<-agify(name = long.small$Names[200001:300000], simplify = FALSE, meta = TRUE)
Age4<-agify(name = long.small$Names[300001:356412], simplify = FALSE, meta = TRUE)

#Combine Age batches 
Age.total<-rbind(Age1, Age2, Age3, Age4)

#Write Age results in CSV just in case 
#write.csv(Age.total, "Age.csv")

#Combine all of the relevant data and write to a csv 
Demo.data.total.Long<-as.data.frame(c(long.small, Gender, Nation.total, Age.total))
#write.csv(Demo.data.total.Long, "EstimatedDemoDataFullLong.csv")

Relevant<-subset(Demo.data.total.Long, select=c(ID, Names, gender, probability, count, country_id, probability.1, age, count.1))

