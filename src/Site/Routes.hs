module Site.Routes
    ( indexedRoute
    , mainToIndex
    ) where

import Hakyll
import System.FilePath ((</>), splitFileName, takeBaseName)

indexedRoute :: Routes
indexedRoute = customRoute $ \i ->
    let (path, name) = splitFileName $ toFilePath i
    in path </> dropDatePrefix name </> "index.html"

  where
    dropDatePrefix = drop 11

mainToIndex :: Routes
mainToIndex = customRoute $ \i ->
    let pathName = takeBaseName $ toFilePath i
    in pathName </> "index.html"
