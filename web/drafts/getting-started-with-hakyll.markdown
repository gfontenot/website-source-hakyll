---
title: Getting started with Hakyll
org: personal
tags: hakyll, haskell
---

intro

## Getting Started

 - Intall Hakyll
   - cabal install hakyll
    - assume haskell installation?
    - Make note of path issues?
 - Create site
   - hakyll-init Blog
   - cabal sandbox init
   - cabal install --dependencies-only
   - cabal build
   - cabal run -- build
 - View site
   - cabal run -- watch
   - pow

## Basic customization

 - match
 - create
 - route
 - compile
 - Combining patterns

## Advanced usage (separate posts?)

 - Indexed urls
 - Working with tags
 - unixFilter
 - Dependencies

## Deployment with CircleCI and GitHub Pages (separate post)

 - Building with Circle
  - Setting the ghc version
  - Overriding the dependency installation
  - Testing (checking urls)
 - Deploying to github pages
  - .nojekyll
  - Deploy script
  - CI deploy script
  - Adding an SSH key to Circle

conclusion

next steps
