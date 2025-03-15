module Main exposing (main)

import Browser
import Browser.Navigation
import Html exposing (Html, button, div, h1, h3, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Url exposing (Url)


type alias ColorPalette =
  { backgroundColor : String
  , foregroundColor : String
  , secondaryBackgroundColor : String
  , secondaryForegroundColor : String
  }


type alias Model =
  { title : String
  , headline : String
  , palette : ColorPalette
  }


type Msg
  = Noop
  | SetPalette ColorPalette


defaultPalette : ColorPalette
defaultPalette =
  { backgroundColor = "#222831"
  , foregroundColor = "#EEEEEE"
  , secondaryBackgroundColor = "#393E46"
  , secondaryForegroundColor = "#00ADB5"
  }


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
  ( initModel, Cmd.none )


initModel : Model
initModel =
  { title = "Mike Taylor"
  , headline = "Software Engineer"
  , palette = defaultPalette
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


view : Model -> Browser.Document Msg
view model =
  { title = model.title
  , body = mainView model
  }


mainView : Model -> List (Html Msg)
mainView model =
  [ div
      [ style "width" "100vw"
      , style "height" "100vh"
      , style "display" "flex"
      , style "flex-direction" "column"
      , style "color" model.palette.foregroundColor
      , style "background-color" model.palette.backgroundColor
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
          , style "color" model.palette.secondaryForegroundColor
          ]
          [ text model.headline ]
      ]
  ]


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
  Noop


onUrlChange : Url -> Msg
onUrlChange _ =
  Noop


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none
