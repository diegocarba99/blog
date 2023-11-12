# This is my blog :)

[![Deployment](https://github.com/diegocarba99/blog/actions/workflows/main.yml/badge.svg)](https://github.com/diegocarba99/blog/actions/workflows/main.yml)

## Prerequisites

- [Hugo](https://gohugo.io/installation/)
- AWS resources
	- S3 bucket
	- Cloudfront CDN

## Start writing

I'm a bit lazy so I created a little bash function that creates the folder and Markdown file needed for the blog. Just make sure
you update the `blog_dir` variable with the path where you keep your blog folder. Paste this in your `.bashrc` or `;zshrc` and you are good to go

```sh
new-blog-entry() {
  if [ $# -eq 0 ]; then
    echo "Please provide the name of the new article"
    exit
  fi

  title="$1"
  blog_dir="$HOME/dev/blog/content"

  cd
  title_lower=$(echo $title | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
  new_dir="$blog_dir/$(date "+%Y%m%d")-$title_lower"

  if [ -d "$new_dir" ]; then
    echo "Directory '$new_dir' already exists."
  else
    mkdir -p "$new_dir"
    touch "$new_dir/$title_lower.md"
    cd $new_dir
    echo "New directory created in $(pwd)"

	echo "---" > $new_dir/$title_lower.md
	echo "title: \"$title\"" > $new_dir/$title_lower.md
	echo "date: $(date "+%Y-%m-%d")" > $new_dir/$title_lower.md
	echo "tags: []" > $new_dir/$title_lower.md
  fi
}
```

Just make sure you update your profile before trying to use the function

```sh
source ~/.bashrc
source ~/.zshrc
```

The you can just create new entries with:

```sh
new-blog-entry "My new blog post"
```


## Locally testing

To view a local version of your blog just run the following command

```
hugo server
```

You'll be able to view your local version in http://localhost:1313. 
Changes are dynamic, so any changes in the files will be replicated into 
your browser.

## Deployment

This blog is hosted on an S3 bucket here the static output of Hugo is served. 
The S3 bucket is behind a CloudFront distribution in order to serve it using HTTPS.
GitHub Actions is used to build the static content and deploy it to the S3 bucket.

![blog-arch](assets/img/blog-arch.png)

# To-Dos

- Create an RSS feed for the blog https://rimdev.io/creating-rss-feeds-using-hugo
- Update https://github.com/diegocarba99/diegocarba99 and add recent blog posts using https://github.com/muesli/readme-scribe