---
title: "How I Use Stuff: Day One"
tags: how-i-use-stuff
---

* App: [Day One](http://dayoneapp.com/)
* Cost:  Free with a [$34.99/year Pro plan](http://help.dayoneapp.com/day-one-2-0/day-one-pricing-features-guide)

My journaling workflow has evolved a _lot_ over the past few years. My very
first entry in Day One is from June 21, 2012, but I didn't start keeping a
regular journal till early November 2015, shortly after I [quit
drinking][quitting]. I turned to keeping a journal as a way to organize my
thoughts and feelings in a place that I knew was private and non-judgmental.
Since then, my usage has largely stayed the same, although I've been able to
be much more consistent in the past year. I've also added a number of smaller
semi-automated entries to my practice.

[quitting]: /blog/quitting

## The Workflow
As of this writing, I have a grand total of 2,144 entries stored in Day One.
Those entries are split up across a few different journals:

### Journal (1,191 Entries)
This is my "main" journal, and is where all of my free-form writing goes. I
don't have any hard and fast rules about this journal, and it's littered with
photos of graffiti I see while traveling, dumb jokes that I don't feel like
posting publicly, and longer form entries. I try to write at _least_ one of
those long-form entries in here every day.

The format for my daily long-form entries has gone through multiple revisions
over time. When I first started keeping a journal, I wrote several entries
each day, each with a specific topic. I wrote one about my workday, one for my
personal thoughts/feelings, and one for each activity I did. That pace wasn’t
maintainable, and it became exhausting. I eventually whittled that down to
just writing a single large daily overview entry, but got a bit burned out on
that as well.

More recently, I've settled into just writing _something_ in here every day. I
try hard to not judge myself on length or quality of the entry. Instead, I
just focus on getting something written down. I've moved away from entries
that are glorified lists of things I did during the day, and I focus more on
writing about what I _feel_. One of the biggest benefits of journaling for me
is being able to look back at where I was years ago and see how things have
changed. The list-style entries have limited interest as time goes on, but the
entries that center around my feelings and general outlook are evergreen.

### Daily Q&A (651 Entries)
When I started my journaling practice, one of the things I wanted to replicate
the most was the [Daily Q&A Journal][physical-q-a-journal] that I bought for
my wife nearly 4 years ago. It's a 5 year journal, but the questions repeat
every year on the same day. As you go through, you answer the question, but
you can also look up to see your answers from the previous years. It's an
amazing way to watch your responses change over time. However, carrying around
a physical book for that was a non-starter for me. Thankfully, Day One has an
excellent "On This Day" feature, where it shows you all the entries you wrote
on the current day of past years. So all that was left was to add prompts.

[physical-q-a-journal]: https://www.amazon.com/Day-5-Year-Journal-Potter-Style/dp/0307719774

After painstakingly transcribing every question in the above physical book and
translating them into JSON, I was able to publish [a super small web app to
spit them back out at me][daily-prompt] ([the source is public if you're
interested][daily-prompt-source]). This lets me outsource the prompts, while
using Day One's own features for the yearly reviews.

[daily-prompt]: http://daily-journal-prompt.herokuapp.com/
[daily-prompt-source]: https://github.com/gfontenot/daily-journal

I've managed to stay super consistent with this, and have gone 417 days now
without missing a question. It's interesting to see my answers from the
previous year, and to see how they have changed. Also entertaining are the
days when I think of an incredibly clever answer only to realize it's the
_exact_ same thing I wrote in a previous year.

### Productivity (154 Entries)
There are two types of entries that go into this journal: Daily and Weekly
productivity entries. These entries are similar to my Q&A entries, except that
they ask the same questions each time:

#### Daily:
* What was something important that you accomplished today?
* What is one thing you're thankful for today?

#### Weekly:
* What were your accomplishments, highlights, and wins from the week?
* What were your failures from the past week, and how could you improve on them?
* What were your loose ends for the week?
* What did you learn or discover this week?
* How are you coming along with your overarching big goals and projects?

I'm prompted to write these as a part of my daily and weekly reviews. I have
[Workflows] set up for guiding me through the prompts and adding them to the
right journal with the right default tags:

[Workflows]: https://www.workflow.is/

 * [Daily Journal Entry workflow](https://workflow.is/workflows/0881f818e77048c4a310e8d853237505)
 * [Weekly Journal Entry workflow](https://workflow.is/workflows/52e62dc773544e1fae78f24507a17b58)

This is the newest addition to my practice, and it's one I'm still refining. I
don't remember what prompted me to start these, but I'm on my 4th month of
writing them, and I've been enjoying it. Initially, these entries lived in my
main journal, but once I decided that I wanted to make it a regular practice,
I created a new journal to hold them.

Writing these has been a nice addition to my practice. The idea is akin to
gratitude journaling, but calling it "Productivity" journaling helps me keep
from getting all fluffy with the entries. It's a nice way to regularly remind
myself of the things I'm getting done and the things I'm enjoying.  The weekly
entries give me a chance to reflect on my successes/failures from the week and
helps me come up with a plan to continue/fix them.

### Home Screens (78 Entries)
Every month I have a recurring task to take a screenshot of my home screens
for my iPad, iPhone, and Apple Watch and dump them in here (with an
appropriate tag). I love the idea of keeping a monthly record of what apps
I've allowed to live on my home screen. It’s also nice to relive these old
setups on the first of each month, when “On This Day” surfaces them again.

### Social (32 Entries)
The entry count here is artificially low because I _still_ haven't gotten
around to importing my backlog, but this is essentially a local copy of [my
microblog](https://micro.gordonfontenot.com). It's currently being populated
via [an RSS trigger through IFTTT][microblog-ifttt]. I wish that Day One had
an API so that I could hit this directly, but until that exists, this will
have to do.

[microblog-ifttt]: https://ifttt.com/applets/52590350d-create-new-journal-entries-from-microblog-posts

### Reading (38 Entries)
This is also populated via IFTTT, and is intended to be a sort of Commonplace
Book, where all interesting quotes from things I read are kept. Unfortunately,
it's incomplete right now because I can only populate it via Instapaper. My
Kindle notes/highlights are siloed away inside Amazon's data centers, and they
don't seem to be particularly interested in letting them out. It's a real
shame, I'd love to be able to export those easily (and automatically).

As it stands, any time I make a highlight in Instapaper [an IFTTT applet
fires][instapaper-ifttt] and an entry is added here.

[instapaper-ifttt]: https://ifttt.com/applets/68248714d-if-new-highlight-then-create-journal-entry

## On Journals and Tags
One common point of confusion/contention with Day One seems to be when to use
journals and when to use tags. The approach I’ve taken is to create journals
when I’m posting about specific thing often enough that it begins to clutter
my main Journal. So for example, I wrote my productivity entries inside
Journal until I decided to do it every day. At that point, the entries started
cluttering that journal and so I moved them all out into their own
Productivity journal. This gave these entries a place to live while also
removing the noise from my main Journal.

Tags, on the other hand, I’m fairly loose with. I create them almost at will.
I have some common ones that I add to larger topics (for example,
`travel/2018/europe` or `work/square`), but others are added arbitrarily. I
don’t put too much time into thinking about them, and don’t have a great
strategy for how to manage them.

## Wishlist
You might have noticed that I'm using a _number_ of tools to overcome some
shortcomings of Day One itself. I'd love to reduce the number of external
tools I use to make my practice work, but I'd first need some improvements to
Day One:

* Template Support. Ideally, templates with multiple prompts. This would
  improve so much about my practice. One of my biggest pain-points right now
  is that since Workflow is on iOS, it means I have to switch to my iPhone in
  order to do those daily/weekly productivity entries. This is especially
  annoying for the weekly entries since those can get long, and I'd much
  rather write those on a full keyboard instead of in an alert on my iPhone.
* External API. This can be (should be?) write only, and could (should?) work
  only with unencrypted journals, but direct API access would let me feel
  _much_ better about things like my microblog entries. Being able to control
  the content without needing to go through IFTT would mean I could ensure
  that my entries are formatted consistently. It would also fix the fact that
  IFTTT "helpfully" strips HTML from any passed text.
* Location-only entries. Or, alternatively, a quicker workflow for adding
  location-based "check-ins" to a specific journal. This could also
  theoretically be achieved if the external API existed, since I could write a
  small wrapper app that posts a location to Day One and Foursquare
  simultaneously. Either way, I'd love to get these into Day One for archival
  and the existing methods of adding location based entries don’t cut it for
  me.
