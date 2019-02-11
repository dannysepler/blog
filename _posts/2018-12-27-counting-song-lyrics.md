---
layout: post
title:  "Lyrics project part 1: counting song lyrics"
date:   2018-12-26 23:45:29 -0500
categories: python nltk lyrics
---

*This will be a multi-part blog post about making sense of text inputs.*

![Picture](/assets/img/in_my_life.jpg){: .image .center }
_"In My Life" -- a personal favorite._{: .text-center }

## Introduction

We're starting this blog post with a simple question: _How can I use code find the most popular words in a song?_

Although we will be using musical lyrics as an example, this is a larger example of working with messy textual inputs. When time permits, we can dive deeper into this subject.

We can try to start as simply as possible in creating a solution, and build out complexities in scope and language from there. All coding will occur in Python. All song lyrics are borrowed from [AZ Lyrics](http://azlyrics.com) as well as the artists themselves, and I take no ownership of them whatsoever.

## Before We Begin

Let us first decide a text to work on. I chose the topical "thank u, next" by Ariana Grande. (Selfishly,) I am hoping it will lend this article some nice Search Engine Optimization for the next few months. Also, and probably more important, it is quite a good song and a fun one to work with.

## Read the Song

Let's start by reading the file, returning a list of the lyrics used in the song.

```python
import re

# Open file and get all words inside of it
def read_file_into_lyrics(file_name):
	lyrics = []
	f = open(file_name, 'r')

	# Any spaces, intentional or otherwise,
	# in the lyrics should be filtered out
	regex_blank = '^\s+$'

	# Uses:
	#     a) line in f.splitlines()
	# rather than:
	#     b) line in f
	# because option b reads in the '\n' character

	for line in f.read().splitlines():
		for lyric in line.split(' '):
			if not re.match(regex_blank, lyric):
				lyrics.append(lyric)

	return lyrics
```

## Count Word Frequency

Next, let's take our list of _all_ the lyrics used in the song, and count the frequency of each one.

```python
from collections import Counter

# Take all words in song, and count by occurrences
def count_lyric_frequency(lyrics):
	return dict(Counter(lyrics))
```

## Display Results

Finally, let's print our results, sorted by most common lyrics first.

```python
# Print out each word and its count, most to least often
def display(lyrics):
	# Sort in reverse order by occurrence value
	sort_lyrics = sorted(lyrics, key=lyrics.get, reverse=True)
	for lyric in sort_lyrics:
		print(lyric + ': ' + str(lyrics[lyric]))

# Put it all together
all_lyrics = read_file_into_lyrics('thank_u_next.txt')
frequency = count_lyric_frequency(all_lyrics)
display(frequency)
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

The work we just performed was a naive implementation of breaking down a wall of text into usable words. Python's _Natural Language ToolKit_ is a comprehensive tool to solve problems just like this one. Simply importing the toolkit, we can use a Regular Expression Tokenizer to swap out our `read_file_into_words` function for a _much_ more concise:

```python
from nltk.tokenize import RegexpTokenizer
tokenizer = RegexpTokenizer(r'\w+') # "\w" means a-z, A-Z, 0-9, and _

def read_file_into_lyrics(file_name):
	lyrics = open(file_name, 'r').read().lower()
	return tokenizer.tokenize(lyrics)
```

Isn't that so much simpler! And more effective. With the aid of a tokenizer, we can solve all four of the problems we identified.

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

## Great, But What About Contractions?

As you can see in the list, some elements: `m` and `ve` for instance, seem to be the result of contractions. Using a tokenizer, the word `I've` was split into `I` and `ve`. While `I` is appropriate, `ve` should have been changed to `have`.

Given that the number of contractions is relatively small, we can use a configurable system to replace any occurrences of contractions with the two words they represent. For configurable code, I find YAML to be an effective pair with Python.

A file such as this can be used to split apart such instances.

`contractions.yml`

```
# Contraction : Replacement
i'd           : i would
i'll          : i will
i'm           : i am
i've          : i have
she's         : she is
he's          : he is
wasn't        : was not
that's        : that is
ain't         : am not
havin'        : having
gon'          : going to
bout          : about
isn't         : isn't
it's          : it is
```

```python
import yaml
contractions = yaml.load(open('contractions.yml', 'r'))

def read_file_into_lyrics(file_name):
	lyrics = open(file_name, 'r').read().lower()

	# Read and replace each contraction occurrence
	for contraction, replacement in contractions.items():
		lyrics = lyrics.replace(contraction, replacement)

	return tokenizer.tokenize(lyrics)
```

## Conclusion

Given a piece of text, we are now able to more effectively count the proximity of each word. There looms another question: how do we get our song text? Next post, I will show how to get a sample source of song data integrated into this system.

<style>
	.text-center {
		display: block;
		text-align: center;
	}

	.darkred { color: darkred; }
	.green   { color: green;   }
	.navy    { color: navy;    }

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