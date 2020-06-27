module Site.Years
    ( Years(..)
    , yearsRules
    , buildYears
    , getYear
    ) where

import Hakyll
import System.FilePath (takeBaseName)
import Control.Monad (foldM, forM_)
import qualified Data.Set as S
import qualified Data.Map as M

data Years = Years
    { yearsMap        :: [(String, [Identifier])]
    , yearsMakeId     :: String -> Identifier
    , yearsDependency :: Dependency
    } deriving (Show)

yearsRules :: Years -> (String -> Pattern -> Rules ()) -> Rules ()
yearsRules years rules =
    forM_ (yearsMap years) $ \(year, identifiers) ->
        rulesExtraDependencies [yearsDependency years] $
            create [yearsMakeId years year] $
                rules year $ fromList identifiers

buildYears :: MonadMetadata m => Pattern -> (String -> Identifier) -> m Years
buildYears pattern makeId = do
    ids <- getMatches pattern
    yearMap <- foldM addYear M.empty ids
    let set' = S.fromList ids
    return $ Years (M.toList yearMap) makeId (PatternDependency pattern set')

  where
    addYear yearMap id' = do
        let year = getYear id'
        let yearMap' = M.singleton year [id']
        return $ M.unionWith (++) yearMap yearMap'

getYear :: Identifier -> String
getYear = take 4 . takeBaseName . toFilePath
