---
layout: post
title:  "Lyrics project part 2: fetching song lyrics"
date:   2018-12-30 23:45:29 -0500
categories: python nltk lyrics
---

![Picture](/assets/img/mr_tambourine_man.png){: .image .center }
_"Mr. Tambourine Man" -- to continue the nostalgia theme from last post._{: .text-center }

## Introduction

This post is a continuation of another post: [Lyrics Project Part 1: Counting Song Lyrics](/blog/python/nltk/lyrics/2018/12/26/counting-song-lyrics.html). The objective of the first post was, given a data set, to show a simple way to count the occurrences of various elements inside of it. In this case, given any song, we built in the ability to search the most popular lyrics.

This post (part 2) is concerned with gathering a data set. I decided on the MusixMatch API to gather songs and [populate my repository](https://github.com/dannysepler/lyrics/tree/master/lyrics) with 100 of today's most popular songs, organized by artist. I will then review the pros and cons of my approach, and possible next steps.

## A Bit of Upfront Research

Originally I considered just copy-pasting lyrics from [AZ Lyrics](http://azlyrics.com). The issue with this was that it was not dynamic at all (imagine if we decided to change the genre of songs we chose -- what a hassle that would be!), and AZ Lyrics has no publically available API to make this process quicker. Not a good way to go about it. 

A cursory glance at online song datasets landed me to the [Million Songs Dataset](https://labrosa.ee.columbia.edu/millionsong/), a pretty cool effort by Columbia University to open up data about songs for anybody to use. This is probably the _best_ option out there for this sort of project, as the number of features in this dataset is extraordinary. However, for the purposes of an introductory post (as well as my first venture into this type of project), it seems to have too large of a learning curve.

(As an example, the Dataset handles all of their files in HD5 files, a format pioneered by NASA to reduce the size of the files they were dealing with. While learning this would be a noble endeavor, I'll save it for my next blog project 🙂)

Upon looking at where the Million Songs Dataset gets its data from, I came across the [MusixMatch Dataset](https://developer.musixmatch.com/). This was an API that could be used to both query types of songs from (for example, the top songs by a given artist, or the most popular songs of a genre), and then query song lyrics as well! It is perfect for our uses.

The MusixMatch Dataset does come with one Achilles' heel -- the free plan for the API only gets 30% of each song's lyrics. This is a real shame. First of all, we will not get all the words for each song. As well, our uniqueness measure we wrote last post will not be very accurate, considering a chorus often plays many times throughout the song (which will not be very evident by the first 30% of each song).

## The Code

I will share the API queries and helpers we can use to fetch and store the top 100 song names (and other relevant information). 


```python
MUSIXMATCH = 'https://api.musixmatch.com/ws/1.1/'
GET_TRACKS = 'chart.tracks.get'

def queryTopHundredTracks():
	
	parameters = {
		'apikey' : '',       # Insert API key here
		'f_has_lyrics': 1,   # 1 = True, 0 = False
		'chart_name': 'top', # Queries the most popular songs
		'page_size': 100,    # Number of responses
		'country': 'us',     # 
		'page': 1            # Paginates for more than 100 responses
	}

	response = requests.get(
		MUSIXMATCH + GET_TRACKS, params=parameters
	)

	file = open('data/top_songs.json', 'w+')
	file.write(json.dumps(response.json(), indent=4))
```

This writes the results to a JSON file. We then loop through that JSON file, querying each song for its lyrics and storing those lyrics in its own file. MusixMatch identifies songs using two criteria: `track_id` and `commontrack_id`.

```python
def displayTopSongs():
	song_data = json.loads(open('data/top_songs.json', 'r').read())
	tracks = song_data['message']['body']['track_list']

	# Loop through tracks
	for track in tracks:

		# Get important information
		artist_name = track['track']['artist_name']
		track_name = track['track']['track_name']
		track_id = track['track']['track_id']
		commontrack_id = track['track']['commontrack_id']
		
		# Create folder if it doesn't exist
		path = 'lyrics/%s' % artist_name
		if not os.path.exists(path):
			os.makedirs(path)

		# Organizing files by artist/song.txt is more readable
		path = os.path.join(path, track_name + '.txt')
		getLyricsAndOutputToText(track_id, commontrack_id, path)
```

Now, `getLyricsAndOutputToText` will closely resemble our `queryTopHundredTracks`. The only distinction is that since we're using the free MusixMatch plan, they tag along a warning that the lyrics are not for commercial use. Considering that we acknowledge this fact, having that warning will get in the way of our data analysis. Therefore, we store the lyrics but remove the warning.


```python
GET_LYRICS = 'track.lyrics.get'
MUSIXMATCH_WARNING = '******* This Lyrics is NOT for Commercial use *******'

def getLyricsAndOutputToText(track_id, commontrack_id, path):
	
	parameters = {
		'apikey': '', # Insert API key here
		'track_id': track_id,
		'commontrack_id': commontrack_id
	}

	data = requests.get(
		MUSIXMATCH + GET_LYRICS, params=parameters
	).json()

	lyrics = data['message']['body']['lyrics']['lyrics_body']
	lyrics = lyrics.replace(MUSIXMATCH_WARNING, '')
	open(path, 'w+').write(lyrics)
```

## Conclusion

Thus, we were able to pluck out the top songs of today, gather their lyrics, and place them into our repository. Given that we used a lyrics API to do so, we can easily change our criteria and recreate this process as we see fit. Say we want to instead focus on an individual artist and pull all of their songs? Easily configurable from the `queryTopHundred` method! If we want to pull a certain genre's top things, also configurable!

Happy lyric-analyzing! 🎶

<style>
	.text-center {
		display: block;
		text-align: center;
	}

	.center {
		display: block;
		margin: 0 auto;
	}

	.image {
		width: 75%;
		min-width: 300px;
		padding:1px;
		background-color: grey;
		border:1px solid #021a40;
	}
</style>