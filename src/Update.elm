module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Noop ->
      ( model, Cmd.none )
    SetPalette palette ->
      ( { model | palette = palette }, Cmd.none )
    WindowResize dimensions ->
      ( { model | dimensions = dimensions }, Cmd.none )
