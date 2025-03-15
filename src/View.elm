module View exposing (view)

import Browser
import Html exposing (Html, button, div, h1, h3, text)
import Html.Attributes exposing (style)

import Background exposing (background)
import Model exposing (Model)
import Msg exposing (Msg)


body : Model -> List (Html Msg)
body model =
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


view : Model -> Browser.Document Msg
view model =
  { title = model.title
  , body = body model
  }
