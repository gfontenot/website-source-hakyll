{-# LANGUAGE OverloadedStrings #-}

import Hakyll hiding (pandocCompiler)

import Site.URLHelper

import Text.Pandoc
    ( writerEmailObfuscation
    , ObfuscationMethod( NoObfuscation )
    )

main :: IO ()
main = hakyll $ do
    match allPosts $ do
        route $ setExtension "" `composeRoutes` indexedRoute
        compile $ pandocCompiler
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= replaceIndexLinks

    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll allPosts
            let blogCtx = mconcat
                    [ listField "posts" postCtx (return posts)
                    , constField "title" siteTitle
                    , defaultContext
                    ]

            makeItem ""
                >>= loadAndApplyTemplate "templates/blog.html" blogCtx
                >>= loadAndApplyTemplate "templates/default.html" blogCtx
                >>= replaceIndexLinks

    create ["feed.xml"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAllSnapshots allPosts "content"
            let feedConfig = FeedConfiguration
                    siteTitle           -- title
                    "Gordon Fontenot"   -- description
                    "Gordon Fontenot"   -- author name
                    "gordon@fonten.io"  -- author email
                    siteHost            -- root

            renderAtom feedConfig feedItemCtx posts
                >>= replaceIndexURLs siteHost
                >>= repairExternalURLs siteHost
                >>= replaceRelativeURLs siteHost

    match "main/*.markdown" $ do
        route convertMainToIndexRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= replaceIndexLinks

    match "404.markdown" $ do
        route $ setExtension ".html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= replaceIndexLinks

    match "pgp/keybase.txt" $ do
        route $ gsubRoute "pgp" (const ".well-known")
        compile copyFileCompiler

    match "root/nojekyll" $ do
        route $ gsubRoute "root/" (const ".")
        compile copyFileCompiler

    compileTemplates $
             "templates/*"
        .||. "partials/*"

    copyInPlace $
             "images/*"
        .||. "css/*"
        .||. "javascript/*"
        .||. "font/*"
        .||. "pgp/*"

    match "root/*" $ do
        route $ gsubRoute "root/" (const "")
        compile copyFileCompiler

pandocCompiler :: Compiler (Item String)
pandocCompiler = pandocCompilerWith
    defaultHakyllReaderOptions
    defaultHakyllWriterOptions { writerEmailObfuscation = NoObfuscation }

siteTitle :: String
siteTitle = "Gordon Fontenot"

siteHost :: String
siteHost = "http://gordonfontenot.com"

allPosts :: Pattern
allPosts = "blog/*.markdown"

compileTemplates :: Pattern -> Rules ()
compileTemplates p = match p $ compile templateCompiler

copyInPlace :: Pattern -> Rules ()
copyInPlace p = match p $ do
    route idRoute
    compile copyFileCompiler

convertMainToIndexRoute :: Routes
convertMainToIndexRoute =
    gsubRoute "main/" (const "")
    `composeRoutes`
    gsubRoute ".markdown" (const "/index.html")

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
