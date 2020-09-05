{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE NamedFieldPuns #-}

import Control.Monad (forM_)
import Data.List (intercalate)
import qualified Data.Map.Strict as Map
import Data.Vector ((!))
import qualified Data.Vector as V
import Text.Show.Pretty (ppShow)

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
  let names = V.fromList ["red", "yellow", "blue"]
      rgbs = V.map (\name -> Map.lookup name namedColors) names
      darks = fmap darken <$> rgbs
  forM_ [0 .. length names - 1] \i ->
    putStrLn $
      intercalate
        " - "
        [(names ! i), (ppShow $ rgbs ! i), (ppShow $ darks ! i)]
