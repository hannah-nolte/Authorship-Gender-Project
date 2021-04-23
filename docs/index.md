---
title: Gender in Plos One Authorship

description: Faith Khumalo (<a href="fmk5@psu.edu">fmk5@psu.edu</a>), Sandeep Krisnakumar (<a href="sandeepkrish@psu.edu">sandeepkrish@psu.edu</a>), Hannah Nolte (<a href="hnolte@psu.edu">hnolte@psu.edu</a>), Rohan Prabhu  (<a href="rsp32@psu.edu">rsp32@psu.edu</a>)
---

# Why investigate authorship in PLOS ONe?
__This first section is similar to the abstract for your report.__ 

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

# Ethics 
This project has some inherent ethical considerations. Due to the use of an API to estimate the gender of published authors, this project inherently produced a gender dichotomy that is not reflective of the true gender spectrum. The API may also have assigned a gender that misaligns with the authors actual gender identification. Further, to ensure that we were able to retain the maximum number of articles in the dataset, the exclusion criteria was the average probability for each paper, rather than the individual probability for each author. This would have inherently led to predictions with lower probability being included in the dataset when other authors in the same paper had higher associated probabilities. 

Additionally, when estimating nationality, the API may have assigned a country code to an author with which the author does not identify with. This misalignment is exacerbated because the API produced a low accuracy for estimated nationality. Moreover, the API is unable to account for multiple ethnic identities or immigration status when predicting nationality. Lastly, the age predicted by the API is unlikely to match the actual age of the author and the accuracy of the estimates was not provided by the API. Hence, while this information is valuable, limited generalizable conclusions should be drawn from these results, especially for the nationality and age data.

# Data

To get our dataset, we first obtained the XML file from PLOS ONE's website which contains all published papers between 2006 and 2019. Due to the absence of the discipline field in the XML files after 2012, only papers published betweeen 2006 and 2012 were considered

![](https://raw.githubusercontent.com/hannah-nolte/Authorship-Gender-Project/main/process%20flowchart%20v2.JPG)


# Methodology

# Results 

# Takeaways
__A final section summarizes big takeaways in a concise format__
- Puppies are cute
- Smoler = cuter
- Future work should investigate how smol is too smol

# References
__Don't foget references!__
1. Reference 1 
