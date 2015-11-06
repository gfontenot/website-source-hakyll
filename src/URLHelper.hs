-- Shamelessly stolen from Pat Brisbin
-- https://github.com/pbrisbin/pbrisbin.com/blob/master/src/IndexedRoute.hs

module URLHelper
    ( indexedRoute
    , replaceIndexLinks
    , replaceIndexURLs
    , replaceRelativeURLs
    , repairExternalURLs
    ) where

import Hakyll

import Data.Monoid ((<>))
import System.FilePath ((</>), splitFileName)

import qualified System.FilePath.Posix as P

indexedRoute :: Routes
indexedRoute = customRoute $ \i ->
    let (path, name) = splitFileName $ toFilePath i
    in path </> dropDatePrefix name </> "index.html"

  where
    dropDatePrefix = drop 11

-- | Replaces @href="/foo/index.html"@ with @href="/foo"@
replaceIndexLinks :: Item String -> Compiler (Item String)
replaceIndexLinks = replace "href=\"/[^\"]*/index.html" P.takeDirectory

-- | Replaces @<host>/foo/index.html@ with @<host>/foo@ for the given host
replaceIndexURLs :: String -> Item String -> Compiler (Item String)
replaceIndexURLs host = replace (host <> "/.*/index.html") P.takeDirectory

-- | Replaces @/images/foo@ with @<host>/foo@ for the given host
replaceRelativeURLs :: String -> Item String -> Compiler (Item String)
replaceRelativeURLs host = replace "=\"/.*\"" prependHost

  where
    prependHost = ("=\"" <> host </>) . (drop 3)

-- | repair urls that have had the given host prepended to them
repairExternalURLs :: String -> Item String -> Compiler (Item String)
repairExternalURLs host = replace (host <> "http") (drop (length host))

replace :: String             -- ^ Regular expression to match
        -> (String -> String) -- ^ Provide replacement given match
        -> Item String
        -> Compiler (Item String)
replace p f = return . fmap (replaceAll p f)
