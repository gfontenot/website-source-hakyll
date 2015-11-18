module Site.Compilers 
    ( baseCompiler
    , sassCompiler
    , compileTemplates
    , copyInPlace
    ) where

import Hakyll
import Text.Pandoc
    ( writerEmailObfuscation
    , ObfuscationMethod( NoObfuscation )
    )

baseCompiler :: Compiler (Item String)
baseCompiler = pandocCompilerWith
    defaultHakyllReaderOptions
    defaultHakyllWriterOptions { writerEmailObfuscation = NoObfuscation }

sassCompiler :: Compiler (Item String)
sassCompiler = getResourceBody
    >>= withItemBody (unixFilter "scss" args)
    >>= return . fmap compressCss
  where
    args = ["-s", "-I", "web/scss/", "--cache-location", "_cache"]

compileTemplates :: Pattern -> Rules ()
compileTemplates p = match p $ compile templateCompiler

copyInPlace :: Pattern -> Rules ()
copyInPlace p = match p $ do
    route idRoute
    compile copyFileCompiler
