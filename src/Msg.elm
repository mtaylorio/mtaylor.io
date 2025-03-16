module Msg exposing (Msg(..))

import Background.Egg
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type Msg
  = Noop
  | SetPalette ColorPalette
  | WindowResize Dimensions
  | EggBackgroundMsg Background.Egg.Msg
