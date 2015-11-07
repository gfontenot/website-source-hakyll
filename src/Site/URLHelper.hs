-- Shamelessly stolen from Pat Brisbin
-- https://github.com/pbrisbin/pbrisbin.com/blob/master/src/IndexedRoute.hs

module Site.URLHelper
    ( replaceIndexLinks
    , replaceIndexURLs
    , replaceRelativeURLs
    , repairExternalURLs
    ) where

import Hakyll

import Data.Monoid ((<>))
import System.FilePath ((</>))

import qualified System.FilePath.Posix as P

-- | Replaces @href="/foo/index.html"@ with @href="/foo"@
replaceIndexLinks :: Item String -> Compiler (Item String)
replaceIndexLinks = replace "href=\"/[^\"]*/index.html" P.takeDirectory

-- | Replaces @<host>/foo/index.html@ with @<host>/foo@ for the given host
replaceIndexURLs :: String -> Item String -> Compiler (Item String)
replaceIndexURLs host = replace (host <> "/.*/index.html") P.takeDirectory

-- | Replaces @/images/foo@ with @<host>/inages/foo@ for the given host
replaceRelativeURLs :: String -> Item String -> Compiler (Item String)
replaceRelativeURLs host = replace "=\"/.*\"" prependHost

  where
    prependHost = ("=\"" <> host </>) . (drop 3)

-- | Repairs urls that have incorrectly had the given host prepended to them
repairExternalURLs :: String -> Item String -> Compiler (Item String)
repairExternalURLs host = replace (host <> "http") (drop $ length host)

replace :: String             -- ^ Regular expression to match
        -> (String -> String) -- ^ Provide replacement given match
        -> Item String
        -> Compiler (Item String)
replace p f = return . fmap (replaceAll p f)
