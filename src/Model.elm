module Model exposing (Model)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type alias Model =
  { title : String
  , headline : String
  , palette : ColorPalette
  , dimensions : Dimensions
  }
