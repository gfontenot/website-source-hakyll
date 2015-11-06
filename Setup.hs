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
copyBinary _ _ desc buildInfo = do
  let exe = findExecutable "site" desc

  when (isJust exe) $ do
    let binaryName = fromJust exe
        dir = buildDir buildInfo

    putStrLn $ "Copying executable '" ++ binaryName ++ "' to current directory..."
    copyFile (dir </> "site" </> binaryName) binaryName

findExecutable :: String -> PackageDescription -> Maybe String
findExecutable name desc = find (name ==) $ map exeName (executables desc)
