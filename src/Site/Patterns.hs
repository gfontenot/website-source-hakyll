{-# LANGUAGE OverloadedStrings #-}

module Site.Patterns
    ( allPosts
    , drafts
    ) where

import Hakyll (Pattern, (.||.))

allPosts :: Pattern
allPosts = "posts/*" .||. "stubs/*"

drafts :: Pattern
drafts = "drafts/*"
