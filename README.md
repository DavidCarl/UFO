# Blogpost - (Mastering RegEx with performance in mind) / (Something else??)

We faced a problem, in a school exam assignment. We had to create a website where it was possible to input names of books which then returned all the cities which was mentioned in the book, or put in the name of a city which then gave a list back of books which mentioned the city, and more. All of the books were a part of Project Gutenberg.

So, the problem we faced were, how do we do this a good and fast way? Since we had around 37400 books and 48900 cities it was quite a problem to solve while also doing to with performance in mind.

How do we solve this problem? We had many thoughts on approaches we could take to solve this problem, but we knew ourself that some of these solutions would be way nicer than others. We had the following ideas:
 - Search in Python3
 - Regex in Python3
 - MySQL full text indexing
 - Regex directly on unix (Since we ran unix based systems)

Written by
Tjalfe Møller & David Carl