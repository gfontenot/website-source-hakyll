module Site.Contexts
    ( blogCtx
    , postCtx
    , feedItemCtx
    ) where

import Hakyll

blogCtx :: String -> [Item String] -> Context String
blogCtx siteTitle posts = mconcat
    [ listField "posts" postCtx (return posts)
    , constField "title" siteTitle
    , defaultContext
    ]

postCtx :: Context String
postCtx = mconcat
    [ dateField "date" "%b %d, %Y"
    , defaultContext
    ]

feedItemCtx :: Context String
feedItemCtx = mconcat
    [ dateField "date" "%a, %d %b %Y %H:%M:%S %z"
    , bodyField "description"
    , defaultContext
    ]
