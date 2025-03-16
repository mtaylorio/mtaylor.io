module Background exposing (background)

import Svg exposing (Svg)

import Background.Egg
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Model exposing (Background)


background : Background -> ColorPalette -> Dimensions -> Svg msg
background = Background.Egg.background
