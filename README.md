# Personal Blog

### Introduction

This was built using Jekyll. Jekyll is a really awesome static site generator you can build using only Markup.

### Instructions:

```bash
# Install dependencies
sudo gem install bundler
bundle install # Takes some time

# Give access to build.sh file
chmod +x build.sh

# Run
./build.sh
```

### Troubleshooting

_(Use this section as you see fit)_

On first `bundle install`, nokogiri failed. I fixed this by installing pkg-config first:

`gem install pkg-config -v "~> 1.1"`