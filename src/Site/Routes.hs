module Site.Routes
    ( indexedRoute
    , makeIndexed
    , wellKnown
    , makeHidden
    , makeRoot
    , toHTML
    ) where

import Hakyll
import System.FilePath
import Data.Monoid ((<>))

indexedRoute :: Routes
indexedRoute = customRoute $ \i ->
    let (path, name) = splitFileName $ toFilePath i
    in path </> dropDatePrefix name </> "index.html"

  where
    dropDatePrefix = drop 11

makeIndexed :: Routes
makeIndexed = customRoute $ \i ->
    let pathName = takeBaseName $ toFilePath i
    in pathName </> "index.html"

wellKnown :: Routes
wellKnown = customRoute $ \i ->
    ".well-known" </> fileName i

makeHidden :: Routes
makeHidden = customRoute $ \i ->
    "." <> fileName i

makeRoot :: Routes
makeRoot = customRoute fileName

toHTML :: Routes
toHTML = setExtension ".html"

fileName :: Identifier -> FilePath
fileName = takeFileName . toFilePath
