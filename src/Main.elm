module Main exposing (main)

import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events
import Browser.Navigation
import Html exposing (Html, button, div, h1, h3, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Task exposing (Task)
import Url exposing (Url)

import Background exposing (background)
import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)


type alias Model =
  { title : String
  , headline : String
  , palette : ColorPalette
  , dimensions : Dimensions
  }


type Msg
  = Noop
  | SetPalette ColorPalette
  | WindowResize Int Int


defaultPalette : ColorPalette
defaultPalette =
  { backgroundColor = "#222831"
  , foregroundColor = "#EEEEEE"
  , secondaryBackgroundColor = "#393E46"
  , secondaryForegroundColor = "#00ADB5"
  }


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
  ( initModel
  , Task.perform
      (\w -> WindowResize (round w.viewport.width) (round w.viewport.height))
      Browser.Dom.getViewport
  )


initModel : Model
initModel =
  { title = "Mike Taylor"
  , headline = "Software Engineer"
  , palette = defaultPalette
  , dimensions = { width = 0, height = 0 }
  }


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = onUrlRequest
    , onUrlChange = onUrlChange
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Noop ->
      ( model, Cmd.none )
    SetPalette palette ->
      ( { model | palette = palette }, Cmd.none )
    WindowResize width height ->
      ( { model | dimensions = { width = width, height = height } }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
  { title = model.title
  , body = mainView model
  }


mainView : Model -> List (Html Msg)
mainView model =
  [ background model.palette model.dimensions
  , div
      [ style "width" "100vw"
      , style "height" "100vh"
      , style "display" "flex"
      , style "flex-direction" "column"
      , style "color" model.palette.foregroundColor
      ]
      [ h1
          [ style "margin-top" "10px"
          , style "margin-bottom" "0"
          , style "margin-left" "10px"
          , style "margin-right" "0"
          ]
          [ text model.title ]
      , h3
          [ style "margin-top" "10px"
          , style "margin-bottom" "0"
          , style "margin-left" "10px"
          , style "margin-right" "0"
          ]
          [ text model.headline ]
      ]
  ]


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ = Noop


onUrlChange : Url -> Msg
onUrlChange _ = Noop


subscriptions : Model -> Sub Msg
subscriptions _ =
  Browser.Events.onResize WindowResize
