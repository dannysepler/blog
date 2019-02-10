---
layout: post
title:  "An Ode to csvkit"
date:   2019-02-08 23:45:29 -0500
categories: csvkit csv
---

## Introduction

[csvkit](https://csvkit.readthedocs.io/en/1.0.3/) is a powerful command line tool that can help make sense of CSV documents easily and quickly!

_For example..._

1. Download sample movie data
`curl -L -O https://raw.githubusercontent.com/dannysepler/blog/gh-pages/assets/data/movies.xlsx`
2. Turn it from an Excel Spreadsheet into a CSV document
`in2csv movies.xlsv > movies.csv`
3. Print the 10 movies by rating, in descending order
`cat movies.csv | csvsort -c vote_average -r | csvcut -c original_title,vote_average | head -n 11`

(We write "11" rather than "10" to account for the header line at the top)

_Why do I care about this?_

If you use data of any sort, csvkit can be a painless way to make sense of it. You can use csvkit organize, transform, and search for something you want in either Excel or CSV format.

_Why not just use Excel?_

Excel is bulky, and often has too many features for a small answerable question. This results in Excel getting slower as a dataset grows larger. If you're trying to answer a simple question, csvkit can deliver your answer quickly!

_Why not just use a Python script?_

Sometimes if you have a simple question, a script can be overkill. Finding what you need may not require writing new code, debugging, and making sure it works. Sometimes it can be as easy as a simple command line statement with csvkit.

## Getting Started

I don't think I can do a better overview to it than the [official tutorial](https://csvkit.readthedocs.io/en/1.0.3/tutorial/1_getting_started.html), which even guides you through a real-world example.
