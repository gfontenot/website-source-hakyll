module Site.Configurations
    ( hakyllConfig
    , feedConfig
    ) where

import Hakyll
    ( FeedConfiguration(..)
    , Configuration
    , defaultConfiguration
    , providerDirectory
    )

import Site.Constants

hakyllConfig :: Configuration
hakyllConfig = defaultConfiguration {
  providerDirectory = "web"
}

feedConfig :: FeedConfiguration
feedConfig = FeedConfiguration
    siteTitle           -- title
    "Gordon Fontenot"   -- description
    "Gordon Fontenot"   -- author name
    "gordon@fonten.io"  -- author email
    siteHost            -- root
