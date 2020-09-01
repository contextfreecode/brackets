{-# LANGUAGE MultiWayIf #-}

import Data.Fixed (mod')
import qualified Data.Map.Strict as Map
import Text.Show.Pretty (ppShow)

data Color
  = Hsv {h, s, v :: Double}
  | Named {name :: String}
  | Rgb {r, g, b :: Double}
  deriving (Show)

hsvToRgb (Hsv h s v) = rgb
  where
    c = s * v
    h1 = h * 6
    x = c * (1 - (abs $ (mod' h1 2) - 1))
    rgb1 =
      if  | h1 < 1 -> Rgb c x 0
          | h1 < 2 -> Rgb x c 0
          | h1 < 3 -> Rgb 0 c x
          | h1 < 4 -> Rgb 0 x c
          | h1 < 5 -> Rgb x 0 c
          | otherwise -> Rgb c 0 x
    m = v - c
    rgb = case rgb1 of
      Rgb r g b -> Rgb (r + m) (g + m) (b + m)

namedColors =
  Map.fromList
    [ ("red", Rgb 1 0 0),
      ("yellow", Rgb 1 1 0),
      ("blue", Rgb 0 0 1)
    ]

toRgb color = case color of
  Hsv {} -> Just $ hsvToRgb color
  Named name -> Map.lookup name namedColors
  Rgb {} -> Just color

main = do
  let colors = [Hsv 1 1 1, Named "yellow", Rgb 0 0 1]
  putStrLn $ ppShow colors
  putStrLn $ ppShow $ map toRgb colors
