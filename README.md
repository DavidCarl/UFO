# Blogpost - (Mastering RegEx with performance in mind) / (Searching in tons of content about a ton of variables)

We faced a problem, in a school exam assignment. We had to create a website where it was possible to input names of books which then returned all the cities which was mentioned in the book, or put in the name of a city which then gave a list back of books which mentioned the city, and more. All of the books were a part of Project Gutenberg.

So, the problem we faced were, how do we do this a good and fast way? Since we had around 37400 books and 48900 cities it was quite a problem to solve while also doing to with performance in mind, since we would have 1.8 billion lookups.

How do we solve this problem? We had many thoughts on approaches we could take to solve this problem, but we knew ourself that some of these solutions would be way nicer than others. We had the following ideas:

 - Search in Python3
 - Regex in Python3
 - MySQL full text indexing
 - grep

---

We tried the different approaches, and we have written a bit about the different ones down below, where we wanna compare our results and findings. All of our test and findings are done on a server with the following specs, 2x6 core CPU (3,33 GHz), 96GB RAM, a RAM Disk and a clean Ubuntu 18.04 install.

## MySQL full text indexing

As we started the assignment this seemed like the most straightfoward solution since it was a database course exam assignment. Our plan for doing it this way was to make a full text index on all the books. We designed our database schema to obtain our fill text indexing on the books, and started to add and index the books in the database.

After a 4-5 of hours of indexing the HDD ran out of space and with no knowledge of progress in indexing our books. We then tried to first add all the books and afterwards index all the books, this approach added the books but failed the indexing, just like our first attempt. We would then had liked to sized up the VM we ran our MySQL Server on but we would have had to redownload all the books again.

Our teacher later on revealed his full text indexing he had performed on his laptop overnight, so he couldnt tell us how much time it took to perform the indexing. But he let us play around with queries on the database for a short time.

## Search in Python3



## Regex in Python3


## grep

We decided to also give greps a try, because we imagined it to be pretty optimised when it came to searching the linux file system. When we started out with our initial grep command it took around 25.8 seconds to lookup a city in all of the 37400 books. In itself we didnt think it was horrible for a single lookup however, we had 48900 to do, and it would turn out to be 14.6 days of total searching. We should be able to optimise it, and hopefully big time. Our initial grep command looked like this `grep -r '$cityName'`

As we only needed which files had the the city name we decided to add the `l` option. We then did a time test to see if it made a difference since it had to output less information to our stdout. It decreased our search time by approximately 16 seconds, just above a 2 times increment in performance, which is a nice improvement. We then looked into what else could increase our time performance, we found the option called `w`, it did not improve our timings BUT, it provided another important aspect in our task. It added the possibility to find matches that was skipped earlier by ignorering special characters such as question marks, exclamations marks, dots, commas and whitespaces. And it didnt worsen our performance either. 

So now our command looks like this `grep -wrl '$cityName'`, however we are still around 9.8 seconds which is still to long, or better known as 19.8 days. So we knew either we had to cut down on our datasets which would seem okay to do since we had so many both books and cities or we needed to find a faster way to do it. We started to think about the obvious way to solve this problem when thinking about what hardware we had on hand, threading... 

We looked into how to do multithreading in bash, since it grep is a bash command, and we stumpled upon `xargs` and `find` as a combo to increase our grep speed.

![](/Screenshot_1.png | width=100)

## Comparison
Even tho we never got to time the MySQL full text indexing and comparing it to our grep commando that we nerded a bit with, our teacher had a full text indexed database we could compare to as said in the section above. Our conclussion on how to do it, depended on some other parameters. 



Written by
Tjalfe Møller & David Carl