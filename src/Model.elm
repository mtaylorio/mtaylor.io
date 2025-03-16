module Model exposing (Background(..), Model)

import Background.Egg
import Background.Flowery
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type Background
  = EggBackground Background.Egg.Model
  | FloweryBackground Background.Flowery.Model


type alias Model =
  { title : String
  , headline : String
  , palette : ColorPalette
  , dimensions : Dimensions
  , background : Background
  }
