module Site.Compilers 
    ( baseCompiler
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

compileTemplates :: Pattern -> Rules ()
compileTemplates p = match p $ compile templateCompiler

copyInPlace :: Pattern -> Rules ()
copyInPlace p = match p $ do
    route idRoute
    compile copyFileCompiler
