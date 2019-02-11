---
layout: post
title:  "Why I love csvkit"
date:   2019-02-08 23:45:29 -0500
categories: csvkit csv
---

## Introduction

[csvkit](https://csvkit.readthedocs.io/en/1.0.3/) is a powerful command line tool that can help make sense of CSV documents easily and quickly! In this post, I will walk through an example of how to use the tool, and defend it against other manners of parsing CSV data.

## Demonstration

_(If you don't have csvkit installed, you can do so through `sudo pip install csvkit`)_

1. Download sample movie data
```bash
curl -L -O https://raw.githubusercontent.com/dannysepler/blog/gh-pages/assets/data/movies.xlsx
```
2. Turn it from an Excel Spreadsheet into a CSV document
```bash
in2csv movies.xlsx > movies.csv
```
3. Print the 10 movies by rating, in descending order
```bash
cat movies.csv | csvsort -c vote_average -r | csvcut -c original_title,vote_average | head -n 11
```

	(We write "11" rather than "10" to account for the header line at the top)

	![csvkit demo](/assets/img/csvkit_demo.png){: .image .center }

	<br/>

4. (Optional) Improve the readability by adding a `| csvlook` at the end

	![csvkit csvlook](/assets/img/csvkit_csvlook.png){: .image .center }

<br/>

## The Three "Why's"

_Why do I care about this?_

If you use data of any sort, csvkit can be a painless way to make sense of it. You can use csvkit organize, transform, and search for something you want in either Excel or CSV format.

_Why not just use Excel?_

Excel is bulky, and often has too many features for a small answerable question. As well, as Excel files get larger and larger, manipulating the data gets slower. If you're trying to answer a simple question, csvkit might be all you need -- and with significant performance improvements!

_Why not just use a Python / Ruby script?_

Sometimes if you have a simple question, a script can be overkill. Finding what you need may not require writing new code, debugging, and making sure it works. Sometimes it can be as easy as a simple command line statement with csvkit.

As the scope of your project gets larger, you may want to transition to more of a script-minded solution. But for debugging purposes / oneoff inquiries, csvkit is a great place to start!

## Learning More

I don't think I can do a better overview of all of csvkit's features than its [official tutorial](https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html), which even guides you through a real-world example. Give it a shot, and see how you like it for yourself!


<style>
	.center {
		display: block;
		margin: 0 auto;
	}

	.image {
		width: 120%;
		padding: 1px;
		background-color: grey;
		border: 1px solid #021a40;
	}
</style>
