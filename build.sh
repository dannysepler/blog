function run_build {
	bundle exec jekyll serve --incremental & # & = don't wait for first command to finish
	open -na "Google Chrome" --args "http://127.0.0.1:4000/blog/"
}

run_build