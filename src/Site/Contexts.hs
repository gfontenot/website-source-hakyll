module Site.Contexts
    ( blogCtx
    , postCtx
    , feedItemCtx
    ) where

import Hakyll

blogCtx :: [Item String] -> Tags -> String -> Context String
blogCtx posts tags title = mconcat
    [ listField "posts" (postCtx tags) (return posts)
    , constField "title" title
    , defaultContext
    ]

postCtx :: Tags -> Context String
postCtx tags = mconcat
    [ dateField "date" "%b %d, %Y"
    , tagsField "tags" tags
    , defaultContext
    ]

feedItemCtx :: Context String
feedItemCtx = mconcat
    [ dateField "date" "%a, %d %b %Y %H:%M:%S %z"
    , bodyField "description"
    , defaultContext
    ]
