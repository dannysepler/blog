---
layout: post
title:  "Pretty Piping: Making Your CSVs Easier To Read"
date:   2019-06-16 01:45:29 -0500
categories: csv
---

## Introduction

[A few months ago](/csvkit), I discussed using [csvkit](https://csvkit.readthedocs.io/en/1.0.3/) to better organize your csv files. Today, I will explore how to make your files _look_ prettier.

We're going to work with a dataset I'm particularly excited about exploring: restaurant complaints in New York City!

```bash
# Download the dataset (this took about 20 seconds for me)
curl -o complaints.csv https://data.cityofnewyork.us/api/views/43nn-pn8j/rows.csv
```

Feel free to check everything download properly! A quick `cat complaints.csv | wc -l` should give about 380,000 rows

## Why even do this?

We have a _lot_ of data right now! Opening this in excel would take a long time, and this is when the beauty of CSV kit really shines. We will probably filter this down into a way that's easier to understand.

That said, if you just `cat` the file, it can seem overwhelming. (Plus it'll just print forever.)

## Creating tables out of your CSVs

[This article](https://www.stefaanlippens.net/pretty-csv.html) by Stefaan Lippens is extraordinarily helpful to create a function to organize CSV fields in a table format. The article itself deserves a full read (it's not very long), but I'll summarize the part I found the most helpful.

Add the following function to your `~/.bash_profile` or `~/.bashrc`:

```bash
function csv_as_table {
    column -t -s, | less -S
}
```

 If you don't have a Mac like me, you may need to read the article for the proper variation of this function. Run a quick `source ~/.bash_profile` or `source ~/.bashrc`, and you can use the function as so (give it a second for the grep):

```bash
 grep "BURGER KING" complaints.csv | csv_as_table
 ```

(Use the arrow keys to go left and right. Use Space and B to go up and down.)

## Rainbow CSVs (from the CLI)

TBD

## Alternatives

Sublime Text has a great [Rainbow CSV plugin](https://github.com/mechatroner/sublime_rainbow_csv) that you could just pipe your results to.

```bash
cat complaints.csv | sublime
```
