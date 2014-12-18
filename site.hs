--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    create ["index.html"] $ do
        route idRoute
        compile  $ do
            posts <- recentFirst =<< loadAll allPosts
            let blogCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/blog.html" blogCtx
                >>= loadAndApplyTemplate "templates/default.html" blogCtx
                >>= relativizeUrls

    match allPosts $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

    match "partials/*" $ compile templateCompiler

    match "images/**/*" copyInPlace

    match "css/*" copyInPlace

    match "javascript/*" copyInPlace

    match "CNAME" copyInPlace

--------------------------------------------------------------------------------
copyInPlace :: Rules ()
copyInPlace = do
    route idRoute
    compile copyFileCompiler

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

allPosts :: Pattern
allPosts = "blog/*.markdown"
