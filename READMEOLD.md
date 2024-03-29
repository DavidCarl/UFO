# Blogpost - Searching in tons of content with a ton of variables

We faced a problem, in a school exam assignment. We had to create a website where it was possible to input names of books which then returned all the cities which was mentioned in the book, or put in the name of a city which then gave a list back of books which mentioned the city, and more. All of the books were a part of Project Gutenberg.

So, the problem we faced were, how do we do this a good and fast way? Since we had around 37.400 books and 48.900 cities it was quite a problem to solve while also doing to with performance in mind, since we would have 1.8 billion lookups.

How do we solve this problem? We had many thoughts on approaches we could take to solve this problem, but we knew ourself that some of these solutions would come with different down and upsides. We had the following ideas:

 - MySQL full text indexing
 - grep

We tried the different approaches, and we have written a bit about the different ones down below, where we wanna compare our results and findings. All of our test and findings are done on a server with the following specs, 2x6 core CPU (3,33 GHz), 96GB RAM, a RAM Disk and a clean Ubuntu 18.04 install.

## MySQL full text indexing

As we started the assignment this seemed like the most straightfoward solution since it was a database course exam assignment. Our plan for doing it this way was to make a full text index on all the books. We designed our database schema to obtain our full text indexing on the books, and started to add and index the books in the database.

After a 4-5 of hours of indexing the disk ran out of space and with no knowledge of progress in indexing our books. We then tried to first add all the books and afterwards index all the books, this approach added the books but failed the indexing, just like our first attempt. We would then had liked to sized up the VM we ran our MySQL Server on but we would have had to redownload all the books again. The amount of storage the VM had was 60GB and 14GB of those was used to store the books.

Our teacher later on revealed his full text indexing he had performed on his laptop overnight, so he couldnt tell us how much time it took to perform the indexing. But he let us play around with queries on the database for a short time.

## grep

We decided to also give greps a try, because we imagined it to be pretty optimised when it came to searching the linux file system. When we started out with our initial grep command it took around 25.8 seconds to lookup a city in all of the 37400 books. In itself we didnt think it was horrible for a single lookup however, we had 48900 to do, and it would turn out to be 14.6 days of total searching. We should be able to optimise it, and hopefully big time. Our initial grep command looked like this `grep -r '$cityName'`

As we only needed which files had the the city name we decided to add the `l` option. We then did a time test to see if it made a difference since it had to output less information to our stdout. Another big thing with this option is how after the first detection in a file it jumps to the next file, and since we only need to know if its written there and not where, its a major thing for us. It decreased our search time by approximately 16 seconds, just above a 2 times increment in performance, which is a nice improvement. 

We then looked into what else could increase our time performance, we found the option called `w`, it did not improve our timings BUT, it provided another important aspect in our task. It added the possibility to find matches that was skipped earlier by ignorering special characters such as question marks, exclamations marks, dots, commas and whitespaces. And it didnt worsen our performance either. 

So now our command looks like this `grep -wrl '$cityName'`, however we are still around 9.8 seconds which is still to long, or better known as 5.5 days. So we knew either we had to cut down on our datasets which would seem okay to do since we had so many both books and cities or we needed to find a faster way to do it. We started to think about the obvious way to solve this problem when thinking about what hardware we had on hand, threading... 

Another aspect to the speeds described above is dependant on what cities we search for, in the timing examples we are using its `London` and its important its with a capital L since `london` gave timings that were twice as big.

### greb benchmarks

#### Single Threaded
![](/Screenshot_1.png)

The numbers used for the graph is in the run_time_data folder.

On the image we can see 3 test groups, each group had a 100 runs to find a stable timing. Group 1 is London, Group 2 is Berlin and Group 3 is Odense. 
The data shown in the graph display a very consistent run time with a standard deviation of 0.12 in Group 1, 0.23 in Group 2 and 0.23 in Group 3.
If we look at the results of the different grep commands we can see that London is mentioned in far more books than Berlin is, and Berlin is mentioned in far more books than Odense is - this correlate well with our runtimes as we skip to the next book after the first match due to the `l` flag in grep, and therefore it skips seaching more text in the less often mentioned city names.
In this case we choose a best case (London) something in the middle (Berlin) and a worst case (Odense).

#### Multi-Threaded

We looked into how to do multithreading in bash, since grep is a bash command, and we stumpled upon `xargs` and `find` as a combo to increase our grep speed. `xargs` has a option P which is the number of threads it will run at a time. Furthermore `xargs` are also used to generate commands with different bash tools that dont play nicely together normally. One example where we use this is our command where we now both use `find` and `grep`, we use `find` to parse specific files to our `grep` command to search in. We found substantial speed in doing it with mulitple threads, however at the same time its not worth it.

![](/Screenshot_2.png)

Here group 1 to 10 represent the amount on threads and 11 is 20 threads. As we can see there is no real performance gains to get from using 4 to 20 threads.

As seen on the graph there is a good performance gain to get by threading it, nonetheless we also reach a point where it is not worth it to use more threads for for our search and instead start multiple searches at the same time. The breakpoint where its not worth it is located at 1 thread in this case. 

As said above we ended up with parallelization since it gave the better performance in our case, and a total runtime of 4-5 hours approximately.

We ended up with the command `find . -type f -print0 | xargs -0 -P $threadCount grep -wrl '$cityName' > ./res/$cityName`

#### Reproducing our benchmark
Its possible to find our test scripts [Single threaded](run.sh) and [multi threaded](RunThreads.sh). Its possible to download the data from [our server](http://www.dcarl.me/archive.tar). You will need to untar and unzip all the files. We recommend to either move the txt files to another folder or delete the zip and tar file afterwards.

## Comparison and Conclusion
Despite the fact that we never got to time the MySQL full text indexing and comparing it to our grep commando that we nerded a bit with, our teacher had a full text indexed database we could compare to as said in the 'MySQL full text indexing' section. Our conclussion on how to do it, depended on how it was supposed to be used. Are we talking about never again adding another city, it would be fastest to use our approach with using grep, with our experience making a Full text index. But if you are looking for having a more flexible database where the user can write whatever word they want, this includes cities and non cities it would definitely be fastest to make the full text indexing, since you are not limited to have such a powerfull server as us to make this quickly analyse the data.

If we had to do the project again we would had used the Full text indexing instead, since we saw the performance. We would still have to figure out how much storage the MySQL server needed since the amount we gave was not enough.

## Written by
### Tjalfe Møller & David Carl