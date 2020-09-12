{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE NamedFieldPuns #-}

import Control.Monad (forM_)
import Data.List (intercalate)
import qualified Data.Map.Strict as Map
import Data.Vector ((!))
import qualified Data.Vector as V

data Rgb = Rgb {r, g, b :: Double} deriving (Show)

scaleBy :: Double -> Rgb -> Rgb
scaleBy scale Rgb {r, g, b} =
  Rgb (scale * r) (scale * g) (scale * b)

darken :: Rgb -> Rgb
darken = scaleBy 0.5

namedColors :: Map.Map String Rgb
namedColors =
  Map.fromList
    [ ("red", Rgb 1 0 0),
      ("yellow", Rgb 1 1 0),
      ("blue", Rgb 0 0 1)
    ]

main :: IO ()
main = do
  -- Should really be using Maybe lookup on named colors.
  let names = V.fromList ["red", "yellow", "blue"]
      rgbs = V.map (namedColors Map.!) names
      darks = V.map darken rgbs
  forM_ [0 .. V.length names - 1] \i ->
    let strings = [names ! i, show $ rgbs ! i, show $ darks ! i]
     in putStrLn $ intercalate " " strings
