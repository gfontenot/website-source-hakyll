module Site.Fields
    ( todayField
    ) where

import Hakyll
    ( Context
    , field
    , unsafeCompiler
    )

import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (formatTime)
import Data.Time.Locale.Compat (defaultTimeLocale)

todayField :: String -> String -> Context a
todayField key format = field key $ \_ -> do
    let locale = defaultTimeLocale
    now <- unsafeCompiler getCurrentTime
    return $ formatTime locale format now
