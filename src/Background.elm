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
    , node "g" [] (backgroundLines True model.hide 50 palette dimensions)
    , node "g" [] (backgroundLines False model.hide 50 palette dimensions)
    ]


backgroundLines :
  Bool -> Bool -> Int -> ColorPalette -> Dimensions -> List (String, Svg msg)
backgroundLines top hide count palette dimensions =
  generateLines top hide count count palette dimensions


generateLine : Bool -> Bool -> Int -> Int -> ColorPalette -> Dimensions -> Svg msg
generateLine top hide n total palette dimensions =
  if top then
    line
      [ x1 (fromInt 0)
      , y1 (fromInt (n * dimensions.height // total))
      , x2 (fromInt (dimensions.width - (n * dimensions.width // total)))
      , y2 (fromInt 0)
      , style (lineStyle hide palette)
      ]
      []
  else
    line
      [ x1 (fromInt dimensions.width)
      , y1 (fromInt (n * dimensions.height // total))
      , x2 (fromInt (dimensions.width - (n * dimensions.width // total)))
      , y2 (fromInt dimensions.height)
      , style (lineStyle hide palette)
      ]
      []


generateLines :
  Bool -> Bool -> Int -> Int -> ColorPalette -> Dimensions -> List (String, Svg msg)
generateLines top hide n total palette dimensions =
  if n == 0 then
    []
  else
    ( "line-" ++ fromInt n, generateLine top hide n total palette dimensions )
    :: generateLines top hide (n - 1) total palette dimensions


lineStyle : Bool -> ColorPalette -> String
lineStyle hide palette = "stroke: " ++ palette.secondaryForegroundColor
  ++ "; transition: all 60s linear; stroke-width: 1px; stroke-dasharray: 10000"
  ++ "; stroke-dashoffset: " ++ fromInt (if hide then 10000 else 0)
  ++ "; stroke-linecap: round;"
