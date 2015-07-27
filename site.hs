{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import IndexedRoute

main :: IO ()
main = hakyll $ do
    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll allPosts
            let blogCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/blog.html" blogCtx
                >>= loadAndApplyTemplate "templates/default.html" blogCtx
                >>= replaceIndexLinks

    match allPosts $ do
        route $ setExtension "" `composeRoutes` indexedRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= replaceIndexLinks

    compileTemplates $
             "templates/*"
        .||. "partials/*"

    copyInPlace $
             "images/**/*"
        .||. "css/*"
        .||. "javascript/*"
        .||. "CNAME"

compileTemplates :: Pattern -> Rules ()
compileTemplates p = match p $ compile templateCompiler

copyInPlace :: Pattern -> Rules ()
copyInPlace p = match p $ do
    route idRoute
    compile copyFileCompiler

postCtx :: Context String
postCtx =
    dateField "date" "%b %d, %Y" `mappend`
    defaultContext

allPosts :: Pattern
allPosts = "blog/*.markdown"
