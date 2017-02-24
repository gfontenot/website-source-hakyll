---
title: An iOS blogging workflow for static sites
tags: development
---

This blog is (at the time of this writing) a static website hosted on GitHub. It's written in [Haskell](https://www.haskell.org/) (using [Hakyll](https://jaspervdj.be/hakyll/)), built on [CircleCI](https://circleci.com/gh/gfontenot/website-source) when I push to `master`, and then deployed to  [GitHub Pages](https://github.com/gfontenot/gfontenot.github.com). It's a fairly complex process, but it's a fun side project, and it's automated enough to fit my needs.

However, because of all these moving parts, I never really nailed down a workflow for writing blog posts on the go. At the very least, I need access to Git in order to publish new posts. So I end up writing and publishing exclusively on my laptop, where I have access to git and vim and my usual dev environment. This deficiency has (I believe) led to the low level of activity on this blog. I only really write things when I have a lot of time and am actively sitting in front of a computer. This means that if inspiration somehow strikes, I tend to not follow up on it. It also means that I'll start posts, but never finish them because I walk away from my computer.

I've been thinking about this deficiency a lot lately, because I've been spending a lot of time working on my [microblog](https://github.com/gfontenot/featureless-void), where I see mobile posting as being a Must Have feature. I'm _probably_ going to be using the [micro.blog](http://micro.blog) iOS app for posting to that (once I write an API), but it got me wondering if there was a good app/reasonable workflow I was missing that would help me to be able to write longer form content on iOS.

## Needs

Let's start with what I _need_ from an iOS blogging solution. Turns out, they are fairly minimal:

### Markdown editing
 
 This is should be obvious. All of my posts are written in Markdown, so I need some basic ability to write/edit markdown. This requirement basically boils down to "can write text in it", because markdown is _designed_ to be easy to write in plain text.
 
### New file creation

I need to be able to create new files, in addition to being able to edit existing ones. If I can't start writing when I have that thought "I should write something about this", the odds of me never writing that post go up dramatically. In addition, I'll need to be able to create posts in a very specific location (`web/posts`, for my repo). I'll _also_ want to be able to create files with a specific format (downcased, normalized version of the title, with a prefix of the date). There's a lot to consider here.
 
### Pushing to GitHub

This is clearly the big one. If I can't push to GitHub, I can't publish. If I can't publish, then what's the point (other than, I suppose, getting my thoughts out of my head to publish later)? This is definitely going to be the sticking point for me. 

## Wants

In addition to the bare minimum things I know I need, there are some things that would be super nice to have if possible:

### A decent editing interface

I think my ideal here is a full-screen interface with as little chrome as possible. Some markdown helpers are fine, but probably not too many. 

### Branch support

Sometimes, I don't want to just post to `master`, and would instead rather push to a branch so that I can open a PR for other people to review. I don't do this _super_ often (I don't _blog_ super often), but I'd like to have the option if I can.

### Draft management

I don't know that I care _too_ much about how drafts are handled, but I definitely want some way to handle them. I'd like to then be able to "promote" drafts to a "published" state. At that point, I'd want to either prepend today's date to the file name, or update the date that the file name already had.

### Multiple repo support

I'd like to be able to use one workflow for my blogging, no matter what blog I'm writing for. For example, the [thoughtbot blog](https://robots.thoughtbot.com) source code is also hosted on GitHub, and works in largely the same way that this one does. If I could re-use my workflow/app to post to that blog, I might contribute there more frequently as well.

### File Templates

I need a pretty specific format for my YAML frontmatter for my posts. It's not a _complex_ format, but I do forget what the format is literally every time I go to write a post. Automating that away would be a huge time saver for me.

## Existing solutions

The first thing I did was look for an existing application that fit my needs. Unfortunately, this is all pretty hard to search for, so I didn't turn up much. But I _did_ find [OctoPage](https://appsto.re/us/rk9UM.i). It's an iOS app that authenticates with GitHub and lets you write/publish new files. It even lets you choose a different repo to look at, although the UI around this is pretty clunky.

However, it's actually impossible for me to give OctoPage a fair shot. The developers decided to hardcode the paths for drafts and posts according to Jekyll's conventions. And since I'm not following those conventions, it can't find my posts or my drafts. Bummer. There's almost definitely a market here for this exact app, but with configurable paths.

## Let's hack something together

I think that, given unlimited time, I would probably build a solution that hits all of the points above. But I have very little time as is, so instead of spending untold hours building something completely custom, let's see if there are existing _pieces_ that I can use to make up the whole.

### GitHub

The first step is the most important. I need to be able to push commits up to my repo. After some looking, I've settled on [Git2Go](http://git2go.com/) as a GitHub app. The UI is really nice, it will allow me to jump around between repos/branches at will, and even do some light editing if needed. Critically, it also has pretty robust [URL scheme support](http://faq.git2go.com/2016/01/24/How-to-use-URL-schemes.html), that I'll be able to use with a markdown editor in order to be able to publish posts.

Since this is doing so little, there's not really too much setup that needs to happen here. Once I'm authenticated with GitHub, I just pull down my `website-source` repo and I'm ready to go.

### Writing/editing/publishing

I looked at a few apps for this, and ended up with a bit of a compromise between power and usability. What I'm looking for at this level is a nice editor that makes it easy to quickly create posts, not _too_ painful to edit them, and simple to send them over to Git2Go for publishing.

My first stop was to check out [1Writer](http://1writerapp.com/). It has a really nice distraction-free UI and you can create custom actions to perform with/on your documents. To top things off, you can even set Git2Go as a file location, which lets you open up files from your git repo _directly_ in 1Writer.

I was able to create a neat URL scheme action for 1Writer that would let me send the current file to my posts directory in Git2Go. They also allow people to publish/share their actions, [so here you go](http://1writerapp.com/action/8ae98). You'll almost definitely want to modify the path if you choose to use it, but its a reasonable starting point.

I _really_ wanted to stop there. It was almost perfect. I wish I _could_ use 1Writer. But ultimately, it wasn't quite powerful enough. So in the end, I settled on [Editorial](http://omz-software.com/editorial/).

Editorial is almost absurdly powerful. Instead of single actions you can perform (like 1Writer has), Editorial can handle workflows built from any number of arbitrary actions. And where the actions in 1Writer are fairly simplistic (consisting of a single input and a single output), Editorial workflows can contain variables, loops, conditionals, you name it. They can use editor commands, URL schemes, or even arbitrary python code (1Writer has JavaScript actions). This means we can do things like formatting today's date and prepending it to the blog post file name before we send it to Git2Go so that the publish date is set properly.

As with 1Writer, Editorial has a website set up to share these workflows, so [here's mine](http://www.editorial-workflows.com/workflow/5819211662229504/5C5rAd6f54c).

In addition, these workflows can be used to create custom file templates. We can actually use custom text input to get the name of the blog post, then use that name to generate a downcased, normalized file name. Then we can add that original name to the yaml frontmatter for the post. Really crazy stuff. Unfortunately, I can't for the life of me figure out how to share these templates, so you'll just have to take my word for it.

Finally, Editorial's preview feature lets you custom the HTML, and you can even link external CSS. So I've actually set up my preview theme to pull the CSS directly from my website, while also using the same basic HTML architecture. When I preview a post now, it almost looks _exactly_ like it will on my blog.

## What's missing?

I'd like a nicer editing interface. 1Writer is beautiful. I'd love it if either 1Writer got more powerful workflows, or if Editorial got a bit of a UI makeover. Either way, I'd be happy.

I'm also not crazy about the fact that my drafts live outside my blog repo. Even worse, drafts _continue_ to live outside the context of my blog repo after I publish them. I'll have to do some continual maintinence to keep my Editorial Dropbox folder clear of published drafts.  It'd be nice if publishing a post would remove it from Editorial as well.

All in all, I think this is going to be really nice. I wrote (and published) this post using this workflow, and I'm super happy with it.
