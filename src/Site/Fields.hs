module Site.Fields
    ( draftField
    , todayField
    ) where

import Hakyll
    ( Context
    , Item(..)
    , boolField
    , field
    , unsafeCompiler
    , matches
    )

import Site.Patterns

import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (formatTime)
import Data.Time.Locale.Compat (defaultTimeLocale)

draftField :: String -> Context a
draftField key = boolField key $ matches drafts . itemIdentifier

todayField :: String -> String -> Context a
todayField key format = field key $ \_ -> do
    let locale = defaultTimeLocale
    now <- unsafeCompiler getCurrentTime
    return $ formatTime locale format now
