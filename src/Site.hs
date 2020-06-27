{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import System.Environment (getArgs)

import Site.Constants
import Site.Routes
import Site.Patterns
import Site.Contexts
import Site.Configurations
import Site.URLHelper
import Site.Compilers

main :: IO ()
main = do
    (action:_) <- getArgs

    let showDrafts = action == "watch"

    hakyllWith hakyllConfig $ do
        tags <- buildTags allPosts $ fromCapture "blog/tags/*/index.html"

        let postsPattern = case showDrafts of
                True -> allPosts .||. drafts
                False -> allPosts

        match postsPattern $ do
            route indexedPostRoute
            compile $ baseCompiler
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/post.html" (postCtx showDrafts tags)
                >>= replaceIndexLinks

        tagsRules tags $ \tag pattern -> do
            route idRoute
            compile $ do
                posts <- recentFirst =<< loadAllSnapshots pattern "content"

                let ctx = mconcat
                        [ listField "posts" (postCtx showDrafts tags) (return posts)
                        , constField "title" tag
                        , defaultContext
                        ]

                makeItem ""
                    >>= loadAndApplyTemplate "templates/tag.html" ctx
                    >>= loadAndApplyTemplate "templates/default.html" ctx
                    >>= replaceIndexLinks

        create ["index.html"] $ do
            route idRoute
            compile $ do
                publishedPosts <- recentFirst =<< loadAll allPosts
                draftPosts <- loadAll drafts

                let posts = case showDrafts of
                        True -> draftPosts ++ publishedPosts
                        False -> publishedPosts

                let ctx = blogCtx showDrafts posts tags

                makeItem ""
                    >>= loadAndApplyTemplate "templates/blog.html" ctx
                    >>= loadAndApplyTemplate "templates/default.html" ctx
                    >>= replaceIndexLinks

        create ["feed.xml"] $ do
            route idRoute
            compile $ do
                posts <- recentFirst =<< loadAllSnapshots allPosts "content"

                renderAtom feedConfig feedItemCtx posts
                    >>= replaceIndexURLs siteHost
                    >>= repairExternalURLs siteHost
                    >>= replaceRelativeURLs siteHost

        match "pages/*" $ do
            route makeIndexed
            compile $ baseCompiler
                >>= loadAndApplyTemplate "templates/page.html" defaultContext
                >>= replaceIndexLinks

        match "resume.html" $ do
            route makeIndexed
            compile copyFileCompiler

        match "404.markdown" $ do
            route toHTML
            compile $ baseCompiler
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= replaceIndexLinks

        match "pgp/keybase.txt" $ do
            route wellKnown
            compile copyFileCompiler

        match "root/nojekyll" $ do
            route makeHidden
            compile copyFileCompiler

        scssDependencies <- makePatternDependency "scss/*.scss"
        rulesExtraDependencies [scssDependencies] $ do
            match "scss/screen.scss" $ do
                route cssRoute
                compile sassCompiler

        match "css/*" $ do
            route cssRoute
            compile compressCssCompiler

        compileTemplates $
                 "templates/*"
            .||. "partials/*"

        copyInPlace $
                 "images/**"
            .||. "javascript/*"
            .||. "font/*"
            .||. "pgp/*"

        match "root/*" $ do
            route makeRoot
            compile copyFileCompiler
