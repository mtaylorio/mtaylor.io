module Background exposing (background)

import String exposing (fromInt)
import Svg exposing (Svg, line, rect, svg)
import Svg.Attributes exposing (height, style, width, x1, x2, y1, y2)
import Svg.Keyed exposing (node)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Model exposing (Background)


background : Background -> ColorPalette -> Dimensions -> Svg msg
background model palette dimensions =
  svg
    [ width (fromInt dimensions.width)
    , height (fromInt dimensions.height)
    , style "position: absolute; top: 0; left: 0; z-index: -1;"
    ]
    [ rect
        [ width (fromInt dimensions.width)
        , height (fromInt dimensions.height)
        , style ("fill: " ++ palette.backgroundColor)
        ]
        []
    , node "g" [] (backgroundLines True True model.hide 50 palette dimensions)
    , node "g" [] (backgroundLines True False model.hide 50 palette dimensions)
    , node "g" [] (backgroundLines False True model.hide 50 palette dimensions)
    , node "g" [] (backgroundLines False False model.hide 50 palette dimensions)
    ]


backgroundLine :
  Bool -> Bool -> Bool -> Int -> Int -> ColorPalette -> Dimensions -> Svg msg
backgroundLine top left hide n total palette dimensions =
  line
    [ x1 (fromInt (lineCoordinate False (not left) n total dimensions.width))
    , y1 (fromInt (lineCoordinate True top n total dimensions.height))
    , x2 (fromInt (lineCoordinate True (not left) n total dimensions.width))
    , y2 (fromInt (lineCoordinate False (not top) n total dimensions.height))
    , style (lineStyle hide palette)
    ]
    []


backgroundLines :
  Bool -> Bool -> Bool -> Int -> ColorPalette -> Dimensions -> List (String, Svg msg)
backgroundLines top left hide total palette dimensions =
  backgroundLines_ top left hide total total palette dimensions


backgroundLines_ :
  Bool -> Bool -> Bool -> Int -> Int -> ColorPalette -> Dimensions -> List (String, Svg msg)
backgroundLines_ top left hide n total palette dimensions =
  if n == 0 then
    []
  else
    ( "line-" ++ fromInt n, backgroundLine top left hide n total palette dimensions )
    :: backgroundLines_ top left hide (n - 1) total palette dimensions


lineCoordinate : Bool -> Bool -> Int -> Int -> Int -> Int
lineCoordinate iterated reversed n total dimension =
  if iterated then
    if reversed then
      dimension - (n * dimension // total)
    else
      n * dimension // total
  else
    if reversed then
      dimension
    else
      0


lineStyle : Bool -> ColorPalette -> String
lineStyle hide palette = "stroke: " ++ palette.secondaryForegroundColor
  ++ "; transition: all 60s linear; stroke-width: 1px; stroke-dasharray: 10000"
  ++ "; stroke-dashoffset: " ++ fromInt (if hide then 10000 else 0)
  ++ "; stroke-linecap: round;"
