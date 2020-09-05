{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE NamedFieldPuns #-}

import Control.Monad (forM_)
import Data.List (intercalate)
import qualified Data.Map.Strict as Map
import Data.Vector ((!))
import qualified Data.Vector as V

data Color = Rgb {r, g, b :: Double} deriving (Show)

darken Rgb {r, g, b} =
  let scale = 0.5
   in Rgb (scale * r) (scale * g) (scale * b)

namedColors =
  Map.fromList
    [ ("red", Rgb 1 0 0),
      ("yellow", Rgb 1 1 0),
      ("blue", Rgb 0 0 1)
    ]

main = do
  -- Should really be using Maybe lookup on named colors.
  let names = V.fromList ["red", "yellow", "blue"]
      rgbs = V.map (namedColors Map.!) names
      darks = V.map darken rgbs
  forM_ [0 .. V.length names - 1] \i ->
    let strings = [names ! i, show $ rgbs ! i, show $ darks ! i]
     in putStrLn $ intercalate " " strings
