---
title: Gender in PLOS ONE Authorship

description: Faith Khumalo (<a href="fmk5@psu.edu">fmk5@psu.edu</a>), Sandeep Krisnakumar (<a href="sandeepkrish@psu.edu">sandeepkrish@psu.edu</a>), Hannah Nolte (<a href="hnolte@psu.edu">hnolte@psu.edu</a>), Rohan Prabhu  (<a href="rsp32@psu.edu">rsp32@psu.edu</a>)
---

# Why investigate authorship in PLOS ONE?

Current research has identified gender, racial, and geographic biases in academic publishing. The goal of this work is to examine how such biases have shifted over time and across disciplines by looking at data from an open source, multidisciplinary journal for the years 2006-2012. In our analyses, we use estimated demographic characteristics, including gender, nationality, and age to examine disparities in publishing. Investigating authorship in this journal will be informative of whether these biases are being addressed in different fields and help all fields to make publication more equittable across gender, race, and age groups. The findings in this paper point to publications having become more gender representative over time with future work needed to examine the nationality and age distributions.

# Ethics 

This project has some inherent ethical considerations. Due to the use of an API to estimate the gender of published authors, this project inherently produced a gender dichotomy that is not reflective of the true gender spectrum. The API may also have assigned a gender that misaligns with the authors actual gender identification. Further, to ensure that we were able to retain the maximum number of articles in the dataset, the exclusion criteria was the average probability for each paper, rather than the individual probability for each author. This would have inherently led to predictions with lower probability being included in the dataset when other authors in the same paper had higher associated probabilities. 

Additionally, when estimating nationality, the API may have assigned a country code to an author with which the author does not identify with. This misalignment is exacerbated because the API produced a low accuracy for estimated nationality. Moreover, the API is unable to account for multiple ethnic identities or immigration status when predicting nationality. Lastly, the age predicted by the API is unlikely to match the actual age of the author and the accuracy of the estimates was not provided by the API. Hence, while this information is valuable, limited generalizable conclusions should be drawn from these results, especially for the nationality and age data.

# Data

To get our dataset, we first obtained the XML file from PLOS ONE's website which contains all published papers between 2006 and 2019. From each XML file, we scraped the title, author names, abtsract, important dates (received, accepted, and publication dates), and the discipline, as seen in the image below. Not pictured in the image is the discipline. We scraped these variables specifically as these were the most relevant to achieveing the goal of our project. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/paper%20example.png)

Due to the absence of the discipline field in the XML files after 2012, only papers published betweeen 2006 and 2012 were considered. To preidct the names, genders, and ages of each author, three APIs were used - Genderize.io, Nationalize.io, and Agify.io. Both Genderize.io and Nationalize.io yield the predicted gender and nationality of a person respecitively using their first name and yield the associated probability of the prediction. Agify.io does not yield a probability and instead provides a count, and was hence not used in the data analysis. The average probability for the predicted nationalities was only 0.37, and was hence not used. Hence, only the predicted genders were used for the analysis. To remove predictions with low probability while also retaining as much data as possible, we removed papers that had an average probability (or acccuracy) less than 0.85. This yielded 35165 papers that formed our data of interest.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/process%20flowchart%20v2.JPG)


# Methodology

Both appropriate statistical methods and machine learning techniques were used to analyze the data of interest. 
- To quantify the gender representation for each paper, a metric where each author on a paper is assigned either 0 or 1 based on their gender (male = 0, female = 1) was used. These assigned values were then summed and divided over the total number of authors of the paper.  
- The abstracts were analyzed using the 2015 version of the Linguistic Inquiry and Word Count software (LIWC; Pennebaker et al., 2015), which is a natural language text processing module. Words within the input text document are compared to LIWC's validated dictionaries indicating ~90 psychometric properties. 
- Principal Component Analysis (PCA) was used to test if the high dimensional output generated by LIWC could be represented using an underlying set of components. 
- K-means clustering using the PCA components was used to determine if the articles could be classified into certain clusters. These clusters could then be compared to the demographic variables such as gender and ethnicity representation scores to investigate if demographic composition of authors influenced their writing style.
- The Lasso regression was used to investigate if there was a relationship between the linguistic properties of the paper abstracts and the representation score for the authors of the paper. The Lasso regression was picked to isolate the most relevant parameters of interest that contribute to the gender representation in publication.


![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/flowchart.2.jpg)


# Results 

## Descriptive Statistics

### Male-Female ratio

The first key result from descriptive statistics was that two-thirds of the authors were estimated to be male (~64%) whereas one-third were estimated to be female (~34%). Moreover, the mean representation score across articles was 0.347 (standard deviation = 0.247).

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%201.png)

### Gender Representation vs Discipline

The second observation from the descriptive statistics was that overall, the mean gender representation scores across disciplines was less than 0.5, indicating that most fields tend to be male dominated. This observation is shown in the figure below. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%202.png)

### Unique Country Codes vs Discipline

Third, we compared the % of unique nationalities present in the authors of the papers and observed that overall, on average, all disciplines had approximately 75% unique country codes.Therefore, the authors of a majority of articles were comprised of diversity in terms of their country of origin. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%203.png)

### Average Predicted Age vs Discipline

Next, we observe that the average estimated age across articles was 48.813 (SD = 6.345) years. Similarly, the average estimated age for each discipline is observed to be approximately 50 years of age and the average estimated age for a paper is unlikely to be below 30 years or above 65 years. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%204.png)

### Range of Predicted Age vs Discipline

The average estimated age range was 29.693 (SD = 11.644) years with the average estimated age range for each discipline being within ±10 years of 30 years which aligns with the total average. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%205.png)

### Change in Gender Representation Scoe over Time

Finally, we analyzed how the gender representations scores of accepted papers evolved over the years, specifically between 2006 and 2012. The results revealed that 2008 saw a significant increase in the mean gender representation scores when compared to previous years. While 2009 also saw a similar increase, there was no change between 2009 and 2011. Finally, the gender representation score of 2012 was significantly higher than all the years prior.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%206.png)

## Clustering Articles based on LIWC Text Modeling

Next, to test if the text analysis data obtained from LIWC could be used to categorize the articles, we performed k-means clustering. Before doing so, the data was normalized and a principal component analysis (PCA) was performed. 

### Dimensionality Reduction using PCA

First, PCA was performed on the raw LIWC output to reduce the dimensionality of the data. Based on the plot of explained variance ratio to number of components shown below, the first fifteen principal components were used for the k-means clustering.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%207.png) 

### Checking Number of Clusters 

Next, to choose the appropriate number of clusters, an elbow plot was generated. Based on the plot below, we see that the inertia converges between 15 and 20 clusters, and, therefore, 15 clusters were used for the k-means clustering.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%208.png)

### Clustering Articles using Reduced Dimension Data

Finally, k-means clustering was performed with 15 clusters. From the results, no visibly identifiable clusters were observed as plotted on two dimensions. This lack of identifiable clusters could be attributed to the multi-dimensional nature of the data. Given that a total of fifteen components were used to cluster the data, there could be some explainable clusters in a higher dimensional space

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%209.png)

## LASSO Regression

We then proceeded to examine whether the LIWC output variables were predictive of gender representation using Lasso regression, a regularization technique used to overcome overfitting in a regression model. This regression is designed for models with features showing high levels of multicollinearity as it performs feature selection. We ran two lasso regressions, with one inclusive of the summary variables and the other without these variables. We used the variance inflation factor (VIF)to detect multicollinearity in the LIWC variables, which measures the correlation and strength of correlation between the explanatory variables. The output below shows the mean VIF across features in the two regressions and is indicative of high multicollinearity among the features in both given that VIF values greater than 5 are indicative of potentially severe correlation between a given feature and other variables in the model. In such an instance, the coefficient estimates and p-values are likely unreliable which is why we resorted to using the Lasso.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2017.png) 
![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2018.png)

The plots below are for the model including summary variables with the first one showing coefficients from the best model adopted using cross-validation. The first few variables appear to have high coefficient values and they include the four main summary variables - analytics, clout, authentic, and tone. 

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2011.png)

This next plot shows the performance of the regression in predicting gender representation of the training data of this dataset with the one below showing the prediction using test data. The top plot shows that the model does better on the training data with the next one showing that predictions on the test data are also well-placed.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2015.png)

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2016.png)

We then repeated the process above having dropped the summary variables from the dataset with resulting coefficients being in the lower range.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2012.png)

The plots below also represent the prediction performance of the model on training and testing data. Again, the model performs better on the training data given its size, but it also does well on predicting the gender representation scores using the test data.

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2013.png)

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/Figure%2014.png)

The model including all features has an r-squared value of 0.99 on predictions using the training data along with a mean squared error (MSE) of 0.002. On the test data, the model outputs an r-squared value of 0.98 and an MSE value of 0.011. With summary variables dropped, the model's r-squared value based on training data data is 0.99 with an MSE of 0.00018. On testing data, the r-squared value is 0.97 with an MSE of 0.003. Overall, dropping the summary variables appears to improve the models' predictive performance.

# Takeaways

The results of this work provide further insight into the demographic disparities that exist within the academic community. 


- The findings confirm that a majority of the articles published in PLOS ONE were predominantly estimated as male, which likely indicates a gender bias in top-tier academic publishing. However, there is also evidence of female authors gaining an increased presence in top-tier academic publishing as the representation score increased over time.  
- While the estimated nationality data has limited accuracy, the findings suggest that nationality diversity in top-tier academic publishing is high. 
- Analysis relating to age suggests that authors publishing in top-tier journals are typically later in their tenure, but there was no estimate of accuracy available for this measure thus future work on age disparities is needed. 


Given that this work only examined publications in one journal thus producing a limited number of publications per discipline, an extension of this work covering more journals will be informative for separate disciplines. Additionally, we would recommend exaiming the accuracy of APIs for estimating demographic data and encourage authors to be cautious when using this methodology. 

# References
1. Pennebaker, J. W., Boyd, R. L., Jordan, K., & Blackburn, K. (2015). The development and psychometric properties of LIWC2015.
2. https://www.statology.org/how-to-calculate-vif-in-python/
