# Blogpost - Optimising querying with Grep

In a world with exponential amount of stored data, data querying is becoming more of a bottleneck. 
This leads to an increased amount of required compute power and time used on queries.
However, this can be resolved with already common tools on hand, that are not too advanced to use.
Addressing this issue can make it cheap and fast with an initial high cost to query through the stored data.


***Please notice***

Everything we cover in this blog post is mainly aimed at improving timings in certain use cases, and may not be the best approach for all use cases.

## Prerequisites for this blog
The prerequisites both covers if you wanna play around with the commands and just general knowledge of what this is.

 - Knowledge about grep
 - A Unix system if you want to test along 

If your knowledge about grep is non existing, we would recommend to read [this](https://www.maketecheasier.com/what-is-grep-and-uses/) blog post.

For the unix based system we would recommend Ubuntu for simplicity, or if you rather want to stick to Windows it should be Windows 10 with WSL. It can be read about [here](https://www.computerhope.com/issues/ch001879.htm).

Now you should be ready to proceed reading our blog post.

## Terms used

 - keyword : The specific word we are looking for

## grep

Our grep command started out looking like this, `grep 'keyword'`. 

### Option r

First off we wanted to search a whole directory full of text files and not just a specific file for our keyword, and since grep is used to search text, and we want to search multiple files. We would need a way to read all the files in a directory recursively, and lucky for us this is baked right into grep as `-R, -r or --recursive`.

Now our grep command looks like this `grep -r 'keyword'`, and using it gets us a search time that is 25.8 seconds. This is searched through our total of 37400 books. When looking at the time, 25.8 seconds through 37400 books it is not bad, but we have a total of 48900 cities to search for. That totals to 14.6 days of searching which is horribly slow.

### Option l

Now that we enabled ourself to search in our whole directory of files, we found out how long it took to search for a city, and all of our cities. We needed a way to make this search quicker, so we looked through the [man page](https://linux.die.net/man/1/grep) for grep. Here we found a option called `-l or --files-with-matches` that had the following 2 attributes, suprress output; instead of printing the line of where the match is, it now only prints the file name. The second attribute which in our case was one of the biggest improvements, it will stop searching after it matches in the file. 

Now our grep command looks like this `grep -rl 'keyword'` and using it gets us a search time that is 9.8 seconds, this is a improvement on 16 seconds / a 62% decrease in search time. Furthermore it also gives us a better format to save to files for further data processing. 

### Option w

There is a problem with grep, that needs to be addressed in our use case. It matches the keyword as long as its in the text without checking if its in another word. So fx, if we search for `London` it will also match on `Londonderry`, which is not what expected to get as return. 

We tried to fix this problem by making a regex pattern to match on `grep -rl -e '[\ \n,.<(\[]London[.,!?<>;:"]'`, it covers most use cases, however there are some it does not catch but its edge cases. We testet this command to see the timings, it gave a average runtime of 42.07 seconds which is a 329.29% decrease in performance compared with our 9.8 second timings we did with `grep -rl 'keyword'`. However we get a cleaner result set, which we also need in this case.

This new timing on 42.07 seconds is pretty horrible and we are at the point now, where it again takes multiple weeks to search through our books. Once again we went diving into the [man page](https://linux.die.net/man/1/grep) hoping for natural implemented way to fix our problem. We found the option `-w or --word-regexp` which did the same as our regex search, while also fixing the worst of our edge cases. We timed our new command `grep -rlw 'keyword'` and got timings down on our `grep -rl 'keyword'` timings again, which is around 9.8 seconds.

### Case sensitivity

We did not do anything about case sensitivity since city names supposed to be capitalised, but if its something you would like to use yourself it can be read about [here.](http://droptips.com/using-grep-and-ignoring-case-case-insensitive-grep)

## grep benchmarks

The way performed our benchmarks is by running it multiple times. Our single threaded test has been run 100 times on each city. Since we had to test so many amount of threads in our multi threaeded benchmark, and we saw the results from our single threaded benchmark, we decided to lower the amount of test to 25 on each.

### Single threaded
![](/Screenshot_1.png)

The numbers used for the graph is in the run_time_data folder.

On the image we can see 3 test groups, each group had a 100 runs to find a stable timing. Group 1 is London, Group 2 is Berlin and Group 3 is Odense. 
The data shown in the graph display a very consistent run time with a standard deviation of 0.12 in Group 1, 0.23 in Group 2 and 0.23 in Group 3.
If we look at the results of the different grep commands we can see that London is mentioned in far more books than Berlin is, and Berlin is mentioned in far more books than Odense is - this correlate well with our runtimes as we skip to the next book after the first match due to the `l` flag in grep, and therefore it skips seaching more text in the less often mentioned city names.
In this case we choose a best case (London) something in the middle (Berlin) and a worst case (Odense).

### Multi threaded

One way of improving the peformance is to utilze 
You can read more about `xargs` [here](https://shapeshed.com/unix-xargs/)

### Parallelization


### How to reproduce our benchmarks


## Conclussion