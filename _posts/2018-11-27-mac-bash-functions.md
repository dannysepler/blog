---
layout: post
title:  "Mac Bash Functions"
date:   2018-11-27 23:45:29 -0500
categories: bash mac
---

*Disclaimer: Although this article is tailored towards other Mac programmers like myself, it is also applicable for Windows users with some tweaks in syntax.*

Ever find yourself running the same command over and over in your terminal window? Bash functions can be a major time-saver!

## What is a bash function?

A bash function, like any other function, is a manner to reuse code. There are two primary syntaxes for bash functions:

```bash
function func_name {
	# contents
}
```

and

```bash
func_name () {
	# contents
}
```


## Sample uses for bash functions

### Build automation

- Bash functions work well for build automation. As an example, I will use this Jekyll blog. Each time I run my blog, I must:

	1. Build the project with `bundle exec jekyll serve`
	2. Open a Chrome window which points to it at `http://127.0.0.1:4000/`.

```bash
function run_build {
	bundle exec jekyll serve &
		# & = don't wait for the first command to finish
	open -na "Google Chrome" --args "http://127.0.0.1:4000/"
}
```

This does both simultaneously. Bash functions can both abstract complex build instructions and speed up the rate at which they're called.

### Proxy switching

- If you work behind a proxy, you may find yourself repeatedly changing your environment variables to point inside and outside the proxy. Save time with a bash function!

```bash
function turn_on_proxy {
	export http_proxy  = "<PROXY>"
	export https_proxy = "<PROXY>"
}

function turn_off_proxy {
	export http_proxy  = "" # blank
	export https_proxy = "" # blank
}
```

## How to call the functions

### Place it in your `~/.bash_profile`

*Function definition:*

```bash
function hello_world {
	echo "Hello world!"
}
```

*Function call from terminal:*

```
user@bash: hello_world
Hello world!
user@bash:
```

**Pro**: Easy calling of the function. Simply open up a fresh terminal window, and call `function_name`!

**Con**: Your bash profile is run each time a new terminal window is opened. Too many functions here can slow your terminal.

### Call from a file

Let's create a new file called `hello_world.sh` and place it in your root `~` directory.

*hello_world.sh*

```bash
# define function
function hello_world {
	echo "Hello world!"
}

# call function
hello_world
```

*Function call from terminal:*

```
user@bash: ~/hello_world.sh
Hello world!
user@bash:
```

By default, `.sh` files do not have permission to be run via terminal. Fix this by running `chmod +x ~/hello_world.sh` before the *first* time you run this function.

## Conclusion

Feel free to use bash functions as you see fit! Happy automating!
