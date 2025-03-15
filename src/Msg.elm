module Msg exposing (Msg(..))

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type Msg
  = Noop
  | SetPalette ColorPalette
  | WindowResize Dimensions
