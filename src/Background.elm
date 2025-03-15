module Background exposing (background)

import String exposing (fromInt)
import Svg exposing (Svg, svg, rect)
import Svg.Attributes exposing (height, width, style)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


background : ColorPalette -> Dimensions -> Svg msg
background palette dimensions =
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
        ]
