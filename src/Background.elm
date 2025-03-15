module Background exposing (background)

import String exposing (fromInt)
import Svg exposing (Svg, line, rect, svg)
import Svg.Attributes exposing (height, style, width, x1, x2, y1, y2)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


background : ColorPalette -> Dimensions -> Svg msg
background palette dimensions =
    svg
        [ width (fromInt dimensions.width)
        , height (fromInt dimensions.height)
        , style "position: absolute; top: 0; left: 0; z-index: -1;"
        ]
        ( rect
            [ width (fromInt dimensions.width)
            , height (fromInt dimensions.height)
            , style ("fill: " ++ palette.backgroundColor)
            ]
            []
        :: backgroundLines 50 palette dimensions )


backgroundLines : Int -> ColorPalette -> Dimensions -> List (Svg msg)
backgroundLines count palette dimensions = generateLines count count palette dimensions


generateLine : Int -> Int -> ColorPalette -> Dimensions -> Svg msg
generateLine n total palette dimensions =
  line
    [ x1 (fromInt (dimensions.width - (n * dimensions.width // total)))
    , y1 (fromInt dimensions.height)
    , x2 (fromInt dimensions.width)
    , y2 (fromInt (n * dimensions.height // total))
    , style (lineStyle palette)
    ]
    []


generateLines : Int -> Int -> ColorPalette -> Dimensions -> List (Svg msg)
generateLines n total palette dimensions =
  if n == 0 then
    []
  else
    generateLine n total palette dimensions
    :: generateLines (n - 1) total palette dimensions


lineStyle : ColorPalette -> String
lineStyle palette = "stroke: " ++ palette.foregroundColor
