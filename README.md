TwitterHashtagR
===============

<h3>Purpose</h3>

This small project aims at helping researchers who are working on SNS and learning analytics collect data in an easier way, specifically those researchers who want to collect data from Twitter by hashtag. There are two scenarios:
1. Collect data from the past
2. Collect data in future

<h3>Authentication, first thing first</h3>

1. Install R (http://www.r-project.org; if you are on a PC, you may want to install R studio (http://www.rstudio.com) too)
2. Create a new application on https://apps.twitter.com (you need a Twitter account first). Remember to set the Callback URL as http://127.0.0.1:1410 when creating the application.
3. Save the consumer key and consumer secret for future use.
4. Run the code in <strong>Authentication.R</strong>; please remember to replace "xxxxx" with your own consumer key and secrets.

<h3>Collect data from the past</h3>

Twitter API limits data collection using hashtag from what happened before. If you have to collect full data in the past, you may consider doing the following things.

1. Search the hashtage on Twitter, and scroll down untill all tweets are loaded on that webpage.
2. Save the webpage as html file on your local drive, and put it in the working directory of R
3. Run the code in <strong>parseTwitterPageByHashtag.R</strong>
4. Type in the Console the function named <strong>getData</strong>. Provide the needed parameters to the function, including the hastag, the file name of the html file you just saved, and the name of output csv file. An example is as: getData('#mayedit2000', 'tweets.html', 'cleanTotalTweets').

<strong>Note</strong>: <i>If the codes in <strong>parseTwitterPageByHashtag.R</strong> don't run or give you errors, please try the codes in <strong>parseTwitterPageByHashtag-version2.R</strong></i>. The steps are exactly the same as above.


<h3>Collect data in future</h3>

If you plan carefully, you can collect the data by hashtag from what will happen in future in an easier way (e.g., some learning activity on Twitter). Please note that this method works only for small scale studies. You may go through the following steps one time per week as the online activities go on.

1. Run the code in <strong>hashtagSearch.R</strong>
2. Type in the Console the function named <strong>tweetCollect</strong>. Provide the needed parameters to the function, including the hashtag you would like to collect data by, number of tweets you would like to collect, and the name of output csv file. An example is as: tweetCollect('#edit2000', 300, 'tweets'). On PC, the same example should be as tweetCollect('#edit2000', 300,  'tweets')
