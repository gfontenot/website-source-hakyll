---
layout: post
title: Wishboard (A work in progress)
type: post
source:

categories:
 - ruby
 - web
 - projects

---
I love [pinboard][]. Love, love, love. So I wrote a little [Sinatra][] app that allows you to tag any bookmark with "want", and have it displayed as a sorta-pretty wishlist with tags and filtering.

The service can be found (for now) hosted on a free [Heroku][] instance at [wishboard.heroku.com][]. The source is available on [github][].

Simply go to `wishboard.heroku.com/<your-pinboard-username>`, and you'll be able to see your generated wishlist. For example, check out [mine][my_wishboard]. Wishboard doesn't display anything that isn't public already, so there's no auth involved. It's just a public RSS feed and some ruby and CSS.

If you want to help fix my shitty CSS, my shitty Ruby, or my shitty HTML, please. By all means. Feel free to fork the hell out of it.

Quick disclaimer: I'm _totally_ cribbing [Brett Terpstra][]'s _fantastic_ custom pinboard stylesheet (available [here][bt-pinboard]) for the styling as it exists right now. I don't know CSS at all, so it's been great to be able to dig through his and try to figure out what he's doing and how. So thanks, Brett. Huge fan.

[pinboard]: http://www.pinboard.in
[Sinatra]: http://www.sinatrarb.com/
[Heroku]: http://www.heroku.com
[wishboard.heroku.com]: http://wishboard.heroku.com
[github]: http://www.github.com/gfontenot/wishboard
[my_wishboard]: http://wishboard.heroku.com/gfontenot
[Brett Terpstra]: http://brettterpstra.com/
[bt-pinboard]: http://brettterpstra.com/pinboard-redesign-experiment/