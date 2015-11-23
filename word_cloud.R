library(twitteR)
library(wordcloud)
library(qdap)

#Change these to match your own keys, tokens and secrets
consumerKey <-  "Insert your consumerKey" 
consumerSecret <-  "Insert your consumerSecret" 
AccessToken <- "Insert your AccessToken"
AccessSecret <- "Insert your AccessSecret"

setup_twitter_oauth(consumerKey, consumerSecret,AccessToken,AccessSecret)

user='walkingrandomly'
timeline = userTimeline(user, n=3200, maxID=NULL, sinceID=NULL, includeRts=TRUE,excludeReplies=FALSE)
textlist <- sapply(timeline, function(x) x$text)

#Strip URLS
textlist=gsub("(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", textlist)

#strip @mentions
textlist=gsub("@(.*)", "", textlist)

#Strip punctuation
textlist=gsub( "[^[:alnum:] ]", "", textlist )

#Split into words
words <-strsplit(textlist, "\\W+", perl=TRUE)

# #Remove common words
words=rm_stopwords(words,c(Top100Words,"me","our","dont","just","rt"))

#Get rid of empty elements
words=words[lapply(words,length)>0]

#Flatten the list of lists
words=unlist(words,recursive = FALSE)
 
#Convert to a sorted frequency table
words=sort(table(words),decreasing=T)
freqs=as.vector(words)
words=names(words)

wordcloud(words,freqs,scale=c(4,0.5),min.freq=1,max.words=200)
