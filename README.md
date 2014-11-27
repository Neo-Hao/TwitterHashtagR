TwitterHashtagR
===============

<h3>Purpose</h3>

This small project aims at helping researchers who are working on SNS and learning analytics collect data in an easier way, specifically those researchers who want to collect data from Twitter by hashtag.

<h3>Usage</h3>

1. Install R (http://www.r-project.org; if you are on a PC, you may want to install R studio (http://www.rstudio.com) too)
2. Create a new application on https://apps.twitter.com (you need a Twitter account first)
2. Save the consumer key and consumer secret for future use.
3. Run the code in Authentication.R
4. Type in the Console the function named connectRegistr. Provide the needed parameters to the function, including consumer Key, consumer Secret, and the folder location you desired to save the authentication token. An example is as: connectRegistr('consumer key', 'consumer secret', '~/R'). On PC, the same example should be as connectRegistr('consumer key', 'consumer secret', 'D:\\R\\')
5. Run the code in hashtagSearch.R
6. Type in the Console the function named tweetCollect. Provide the needed parameters to the function, including the hashtag you would like to collect data by, number of tweets you would like to collect, and the folder location you desired to save the data. An example is as: tweetCollect('#statistics', 300, '~/R'). On PC, the same example should be as tweetCollect('#statistics', 300,  'D:\\R\\')
