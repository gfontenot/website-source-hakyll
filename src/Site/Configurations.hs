module Site.Configurations
    ( feedConfig
    ) where

import Hakyll (FeedConfiguration(..))

import Site.Constants

feedConfig :: FeedConfiguration
feedConfig = FeedConfiguration
    siteTitle           -- title
    "Gordon Fontenot"   -- description
    "Gordon Fontenot"   -- author name
    "gordon@fonten.io"  -- author email
    siteHost            -- root

