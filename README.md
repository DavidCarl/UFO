# Blogpost - (Mastering RegEx with performance in mind) / (Searching in tons of content about a ton of variables)

We faced a problem, in a school exam assignment. We had to create a website where it was possible to input names of books which then returned all the cities which was mentioned in the book, or put in the name of a city which then gave a list back of books which mentioned the city, and more. All of the books were a part of Project Gutenberg.

So, the problem we faced were, how do we do this a good and fast way? Since we had around 37400 books and 48900 cities it was quite a problem to solve while also doing to with performance in mind, since we would have 1.8 billion lookups.

How do we solve this problem? We had many thoughts on approaches we could take to solve this problem, but we knew ourself that some of these solutions would be way nicer than others. We had the following ideas:

 - Search in Python3
 - Regex in Python3
 - MySQL full text indexing
 - grep

---

We tried the different approaches, and we have written a bit about the different ones down below, where we wanna compare our results and findings. All of our test and findings are done on a server with the following specs, 2x6 core CPU (3,33 GHz), 96GB RAM, a 5400RPM HDD and a clean Ubuntu 18.04 install.

## MySQL full text indexing

As we started the assignment this seemed like the most straightfoward solution since it was a database course exam assignment. Our plan for doing it this way was to make a full text index on all the books. We designed our database schema to obtain our fill text indexing on the books, and started to add and index the books in the database.

After a 4-5 of hours of indexing the HDD ran out of space and with no knowledge of progress in indexing our books. We then tried to first add all the books and afterwards index all the books, this approach added the books but failed the indexing, just like our first attempt. We would then had liked to sized up the VM we ran our MySQL Server on but we would have had to redownload all the books again.

Our teacher later on revealed his full text indexing he had performed on his laptop overnight. 

## Search in Python3



## Regex in Python3


## grep

We decided to also give greps a try, because we imagined it to be pretty optimised when it came to searching the linux file system. When we started out with our initial grep command it took between 45 seconds to lookup a city in all of the 37400 books. In itself we didnt think it was horrible for a single lookup however, we had 48900 to do, and it would turn out to be 25.5 days of total searching. We should be able to optimise it, and hopefully big time. Our initial grep command looked like this `grep -r '$cityName' .` 

## Comparison
While 


Written by
Tjalfe Møller & David Carl