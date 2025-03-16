module Msg exposing (Msg(..))

import Background.Egg
import Background.Flowery
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type Msg
  = Noop
  | SetPalette ColorPalette
  | WindowResize Dimensions
  | EggBackgroundMsg Background.Egg.Msg
  | FloweryBackgroundMsg Background.Flowery.Msg
