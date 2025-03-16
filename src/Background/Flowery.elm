module Background.Flowery exposing (Model, Msg(..), initModel, update, view)

import String exposing (fromInt)
import Svg exposing (Svg, path, rect, svg)
import Svg.Attributes exposing (d, fill, width, height, style)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Position exposing (Position)


type Node = Node
  { root : Position
  , split : Position
  , branches : List Node
  }


type alias Model = List Node


type Msg
  = NoOp
  | Reset


initModel : Model
initModel = []


update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp ->
      model
    Reset ->
      initModel


view : Dimensions -> ColorPalette -> Model -> Svg msg
view dimensions palette model = svg
  [ width <| fromInt dimensions.width
  , height <| fromInt dimensions.height
  , style "position: absolute; top: 0; left: 0; z-index: -1;"
  ]
  ( rect
      [ width <| fromInt dimensions.width
      , height <| fromInt dimensions.height
      , fill <| palette.backgroundColor
      ]
      []
    :: List.concatMap (viewNodes dimensions palette) model
  )


viewNodes : Dimensions -> ColorPalette -> Node -> List (Svg msg)
viewNodes dimensions palette (Node node) =
  let
    root = node.root
    split = node.split
    branches = node.branches
  in
    List.map (viewNode dimensions palette (Node node)) branches


viewNode : Dimensions -> ColorPalette -> Node -> Node -> Svg msg
viewNode dimensions palette (Node parent) (Node node) = path
  [ d <| "M " ++ fromInt (parent.root.x) ++ " " ++ fromInt (parent.root.y)
          ++ " Q " ++ fromInt (parent.split.x) ++ " " ++ fromInt (parent.split.y)
          ++ " " ++ fromInt (node.root.x) ++ " " ++ fromInt (node.root.y)
  , fill <| palette.foregroundColor
  ]
  []
