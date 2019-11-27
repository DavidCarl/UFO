# Blogpost - (Mastering RegEx with performance in mind) / (Something else??)

We faced a problem, in a school exam assignment. We had to create a website where it was possible to input names of books which then returned all the cities which was mentioned in the book, or put in the name of a city which then gave a list back of books which mentioned the city, and more. All of the books were a part of Project Gutenberg.

So, the problem we faced were, how do we do this a good and fast way? Since we had around 37400 books and 48900 cities it was quite a problem to solve while also doing to with performance in mind, since we would have 1.8 billion lookups.

How do we solve this problem? We had many thoughts on approaches we could take to solve this problem, but we knew ourself that some of these solutions would be way nicer than others. We had the following ideas:

 - Search in Python3
 - Regex in Python3
 - MySQL full text indexing
 - Regex directly on unix (Since we ran unix based systems) / grep regex

---

We tried the different approaches, and we have written a bit about the different ones down below, where we wanna compare our results and findings. All of our test and findings are done on a server with the following specs, 2x6 core CPU (3,33 GHz), 96GB RAM, a 5400RPM HDD and a clean Ubuntu 18.04 install.

## MySQL full text indexing

As we started the assignment this seemed like the most straightfoward solution since it was a database course exam assignment. Our plan for doing it this way was to make a full text index on all the books. We designed our database schema to obtain our fill text indexing on the books, and started to add and index the books in the database.

After a 4-5 of hours of indexing the HDD ran out of space and with no knowledge of progress in indexing our books. We then tried to first add all the books and afterwards index all the books, this approach added the books but failed the indexing, just like our first attempt. We would then had liked to sized up the VM we ran our MySQL Server on but we would have had to redownload all the books again.

Our teacher later on revealed his full text indexing he had performed on his laptop overnight. 

## Search in Python3



## Regex in Python3


## grep


## Comparison
While 


Written by
Tjalfe Møller & David Carl