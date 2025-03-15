module Main exposing (main)

import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events
import Html.Events exposing (onClick)
import Task exposing (Task)
import Url exposing (Url)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Init exposing (init)
import Model exposing (Model)
import Msg exposing (..)
import Update exposing (update)
import View exposing (view)


main : Program () Model Msg
main = Browser.application
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  , onUrlRequest = onUrlRequest
  , onUrlChange = onUrlChange
  }


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ = Noop


onUrlChange : Url -> Msg
onUrlChange _ = Noop


subscriptions : Model -> Sub Msg
subscriptions _ =
  Browser.Events.onResize (\w h -> WindowResize { width = w, height = h })
