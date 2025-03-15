module Model exposing (Background, Model)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type alias Background = { hide : Bool }


type alias Model =
  { title : String
  , headline : String
  , palette : ColorPalette
  , dimensions : Dimensions
  , background : Background
  }
