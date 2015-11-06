import Distribution.Simple
import Distribution.Simple.Setup (BuildFlags)

import Distribution.Simple.LocalBuildInfo
    ( LocalBuildInfo
    , buildDir
    )

import Distribution.PackageDescription
    ( PackageDescription
    , exeName
    , executables
    )

import Control.Monad (when)
import Data.Maybe (isJust, fromJust)
import Data.List (find, isPrefixOf)
import System.Directory (copyFile)
import System.FilePath ((</>))

main :: IO ()
main = do
  defaultMainWithHooks $ simpleUserHooks { postBuild = copyBinary }

copyBinary :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
copyBinary _ _ _ buildInfo = do
  let binaryName = "site"
  let dir = buildDir buildInfo

  putStrLn $ "Copying executable '" ++ binaryName ++ "' to current directory..."
  copyFile (dir </> binaryName </> binaryName) binaryName
