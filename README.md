# Website Source #

[![Circle CI](https://circleci.com/gh/gfontenot/website-source/tree/master.svg?style=svg)](https://circleci.com/gh/gfontenot/website-source/tree/master)

This is the source code for gordonfontenot.com. The site is written in
[Hakyll], and pushed here. Pushes to `master` are then picked up by [CircleCI]
where the static site is built, and then the whole thing is deployed to
[GitHub Pages].

[Hakyll]: http://jaspervdj.be/hakyll/
[CircleCI]: https://circleci.com/gh/gfontenot/website-source
[GitHub Pages]: https://github.com/gfontenot/gfontenot.github.com

## Local Development ##

### Dependencies ###

You'll need to have `stack` and `ghc` installed. If you're on OS X, you can do
that with homebrew:

```
% brew update
% brew install haskell-stack
```

It's going to take a while.

Once you have that installed, you can run `bin/setup` to install the app
dependencies.

### Running the app locally ###

Since it's a static site, you'll need to build it first. The easiest way to do
this is by building the `site` compiler and sending it commands with `stack
exec`:

```
% stack build
% stack exec site -- build
```

This will generate the built website at `./_site`. You can then view the
contents of this site with your static-site server of choice. I use [pow]:

[pow]: http://pow.cx

```
% cd ~/.pow
% mkdir gordonfontenot/public
% cd gordonfontenot/public
% ln -s /path/to/_site
```

Then you will be able to view the generated site at `gordonfontenot.dev`.

### Viewing changes ###

Generally, you will be able to update the built site by running `stack exec
site -- build`. However, if you run into issues with cached pages, you can run
`stack exec site -- rebuild` to force a regeneration of the entire site. After that,
you can reload the page and see the updates.
