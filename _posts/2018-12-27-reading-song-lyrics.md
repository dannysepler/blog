---
layout: post
title:  "Reading Song Lyrics"
date:   2018-12-26 23:45:29 -0500
categories: python nltk lyrics
---

*This will probably be a multi-part blog post about making sense of text inputs.*

![Picture](/blog/assets/img/in_my_life.jpg){: .image .center }
_"In My Life" -- a personal favorite._{: .text-center }

## Introduction

We're starting this blog post with a simple question: _How can I use code find the most popular words in a song?_

Although I will be using musical lyrics as an example, this is a larger example of working with messy textual inputs. When time permits, I can dive deeper into this subject.

I will try to start as simply as possible in creating a solution, and build out complexities in scope and language from there. All coding will occur in Python. All song lyrics are borrowed from [AZ Lyrics](http://azlyrics.com) as well as the artists themselves, and I take no ownership of them whatsoever.

## Before We Begin

Let us first decide a text to work on. I chose the topical "thank u, next" by Ariana Grande. (Selfishly,) I am hoping it will lend this article some nice Search Engine Optimization for the next few months. Also, and probably more important, it is quite a good song.

## Reading A File

Let's start with a very simple file read. As this is fairly straightforward syntax, I will simply paste an example of how to do so here.

```python
import re

# Open file and get all words inside of it
def read_file_into_words(file_name):
	words = []
	f = open(file_name, 'r')

	# Any spaces, intentional or otherwise,
	# in the lyrics should be filtered out
	regex_blank = '^\s+$'

	# Uses:
	#     a) line in f.splitlines()
	# rather than:
	#     b) line in f
	# because option b reads in the '\n' character

	for line in text.read().splitlines():
		for word in line.split(' '):
			if not re.match(regex_blank, word):
				words.append(word)

	return words

# Call the function by...
read_file_into_words('thank_u_next.txt')
```

## Counting Word Occurrences

Now let's tally up all the number of occurrences of each word, and print out the results.

```python
# Take all words in song, and count by occurrences
def count_word_occurrences(words):
	count = {}
	
	for w in words:
		count[w] = 1 if w not in count else count[w] + 1

	return count

# Print out each word and its count, most to least often
def display_word_count(word_map):

	# Sort in reverse order by occurrence value
	sort_words = sorted(word_map, key=word_map.get, reverse=True)

	for word in sort_words:
		print(word + ': ' + str(word_map[word]))
```

## Debugging

Let's take a look at what happens when we run our code through the lyrics of "thank u, next" so far...

```
you,: 35
Thank: 27
next: 27
I: 14
so: 12
for: 11
I'm: 10
: 10
I've: 10
my: 8
next): 8

... (skipping a few)

But: 5
and: 5
And: 5
```

Woot! I doubt this list would come as a surprise. But, if you look at the words.... huh... they don't look quite right. Let's point out some flaws:

1. Punctuation counts separately, as in `next` and `next)`
2. This is case insensitive, as in `and` and `And`
3. It seems we counted a blank character ten times
4. We counted three variations of the word `I` separately

If only there were a tool to help us through some of this...

## Introducing the <span class="darkred">Natural</span> <span class="green">Language</span> <span class="navy">ToolKit</span>!

The work we just performed was a naive implementation of breaking down a wall of text into usable words. Python's _Natural Language ToolKit_ is a comprehensive tool to solve problems just like this one. Simply importing the toolkit, we can use a Regular Expression Tokenizer to swap out our `read_file_into_words` function for a much more concise:

```python
from nltk.tokenize import RegexpTokenizer
tokenizer = RegexpTokenizer(r'\w+') # "\w" means a-z, A-Z, 0-9, and _

def read_file_into_words(file_name):
	f = open(file_name, 'r')
	text = tokenizer.tokenize(f.read())
	return [word.lower() for word in text]
```

With this, we can solve all four of the problems we identified.

```
next: 42
you: 38
i: 37
thank: 37
yeah: 15
so: 14
for: 11
and: 10
m: 10
ve: 10
```

As you can see, many of our word counts jumped drastically! "Next" jumped from 27 to 42, and "I" jumped from 14 to 37.

You may be asking, _What is a "Tokenizer"?_ A Tokenizer is a tool to separate an entity into small chunks using simple criteria. For the purpose of this example, we use a token to be any sort of text that does not follow the `\w` Regular Expression pattern. Mainly, any non-alphanumeric character will be split.

<style>
	.text-center {
		display: block;
		text-align: center;
	}

	.darkred { color: darkred; }
	.green { color: green; }
	.navy { color: navy; }

	.center {
		display: block;
		margin: 0 auto;
	}

	.image {
		width: 50%;
		min-width: 300px;
		padding:1px;
		background-color: grey;
		border:1px solid #021a40;
	}
</style>