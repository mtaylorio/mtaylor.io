module Update exposing (update)

import Background.Egg
import Background.Flowery
import Model exposing (Background(..), Model)
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
    EggBackgroundMsg m ->
      case model.background of
        EggBackground bg ->
          let
            bg_ = Background.Egg.update m bg
          in
            ( { model | background = EggBackground bg_ }, Cmd.none )
        _ ->
          ( model, Cmd.none )
    FloweryBackgroundMsg m ->
      case model.background of
        FloweryBackground bg ->
          let
            bg_ = Background.Flowery.update m bg
          in
            ( { model | background = FloweryBackground bg_ }, Cmd.none )
        _ ->
          ( model, Cmd.none )
