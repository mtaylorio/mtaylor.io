module Background exposing (background)

import Svg exposing (Svg, map)

import Background.Egg
import Background.Flowery
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Model exposing (Background(..))
import Msg exposing (Msg(..))


background : Background -> ColorPalette -> Dimensions -> Svg Msg
background model palette dimensions =
  case model of
    EggBackground bg ->
      map EggBackgroundMsg (Background.Egg.view dimensions palette bg)

    FloweryBackground bg ->
      Background.Flowery.view dimensions palette bg
