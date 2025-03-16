module Init exposing (init)

import Browser.Dom
import Browser.Navigation
import Platform.Cmd exposing (batch)
import Url exposing (Url)
import Task exposing (Task)

import Background.Flowery exposing (initModel)
import ColorPalette exposing (ColorPalette)
import Model exposing (Background(..), Model)
import Msg exposing (Msg(..))


palette : ColorPalette
palette =
  { backgroundColor = "#000000"
  , foregroundColor = "#EEEEEE"
  , secondaryBackgroundColor = "#393E46"
  , secondaryForegroundColor = "#00ADB5"
  }


model : Model
model =
  { title = "Mike Taylor"
  , headline = "Software Engineer"
  , palette = palette
  , dimensions = { width = 0, height = 0 }
  , background = FloweryBackground initModel
  }


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
  ( model
  , batch
    [ Task.perform
        (\w -> WindowResize
          { width = round w.viewport.width
          , height = round w.viewport.height
          }
        )
        Browser.Dom.getViewport
    ]
  )
