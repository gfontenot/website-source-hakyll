{-# LANGUAGE OverloadedStrings #-}

module Site.Patterns (allPosts) where

import Hakyll (Pattern)

allPosts :: Pattern
allPosts = "blog/*"
