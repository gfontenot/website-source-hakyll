module Site.Contexts
    ( blogCtx
    , postCtx
    , feedItemCtx
    ) where

import Hakyll

import Site.Constants
import Site.Fields

blogCtx :: Bool -> [Item String] -> Tags -> Context String
blogCtx showDrafts posts tags = mconcat
    [ listField "posts" (postCtx showDrafts tags) (return posts)
    , constField "title" siteTitle
    , defaultContext
    ]

postCtx :: Bool -> Tags -> Context String
postCtx showDrafts tags = mconcat $
    draftFields showDrafts ++ postFields tags

draftFields :: Bool -> [Context String]
draftFields False = []
draftFields True =
    [ todayField "date" "%b %d, %Y"
    ]

postFields :: Tags -> [Context String]
postFields tags =
    [ dateField "date" "%b %d, %Y"
    , draftField "isDraft"
    , tagsField "tags" tags
    , defaultContext
    ]

feedItemCtx :: Context String
feedItemCtx = mconcat
    [ dateField "date" "%a, %d %b %Y %H:%M:%S %z"
    , bodyField "description"
    , defaultContext
    ]
