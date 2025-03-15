module Background exposing (background)

import List exposing (concat)
import String exposing (fromInt)
import Svg exposing (Svg, line, node, rect, svg)
import Svg.Attributes exposing (height, style, width, x1, x2, y1, y2)

import ColorPalette exposing (ColorPalette)
import Dimensions exposing (Dimensions)
import Model exposing (Background)


type alias OffsetFunction = Int -> Int


type alias OffsetFunctions =
  { x1 : OffsetFunction
  , y1 : OffsetFunction
  , x2 : OffsetFunction
  , y2 : OffsetFunction
  }


background : Background -> ColorPalette -> Dimensions -> Svg msg
background model palette dimensions =
  svg
    [ width (fromInt dimensions.width)
    , height (fromInt dimensions.height)
    , style "position: absolute; top: 0; left: 0; z-index: -1;"
    ]
    [ rect
        [ width (fromInt dimensions.width)
        , height (fromInt dimensions.height)
        , style ("fill: " ++ palette.backgroundColor)
        ]
        []
    , node "g" [] (bgls palette model.hide dimensions 10)
    ]


bgl : ColorPalette -> Bool -> OffsetFunctions -> Int -> Svg msg
bgl palette hide offsets segment =
  line
    [ x1 (fromInt (offsets.x1 segment))
    , y1 (fromInt (offsets.y1 segment))
    , x2 (fromInt (offsets.x2 segment))
    , y2 (fromInt (offsets.y2 segment))
    , style (lineStyle hide palette)
    ]
    []


bgls_ : ColorPalette -> Bool -> OffsetFunctions -> Int -> List (Svg msg)
bgls_ palette hide offsets n =
  if n == 0 then
    []
  else
    bgl palette hide offsets n
    :: bgls_ palette hide offsets (n - 1)


bgls : ColorPalette -> Bool -> Dimensions -> Int -> List (Svg msg)
bgls palette hide dimensions segments = concat
  [ bgls_ palette hide
      { x1 = iterated True False dimensions.width segments
      , y1 = always 0
      , x2 = always dimensions.width
      , y2 = iterated False False dimensions.height segments
      }
      segments
  , bgls_ palette hide
      { x1 = always dimensions.width
      , y1 = iterated True False dimensions.height segments
      , x2 = iterated True True dimensions.width segments
      , y2 = always dimensions.height
      }
      segments
  , bgls_ palette hide
      { x1 = iterated False True dimensions.width segments
      , y1 = always dimensions.height
      , x2 = always 0
      , y2 = iterated True True dimensions.height segments
      }
      segments
  , bgls_ palette hide
      { x1 = always 0
      , y1 = iterated False True dimensions.height segments
      , x2 = iterated False False dimensions.width segments
      , y2 = always 0
      }
      segments
  ]


lineStyle : Bool -> ColorPalette -> String
lineStyle hide palette = "stroke: " ++ palette.secondaryForegroundColor
  ++ "; transition: all 10s linear; stroke-width: 1px; stroke-dasharray: 5000"
  ++ "; stroke-dashoffset: " ++ fromInt (if hide then 5000 else 0)
  ++ "; stroke-linecap: round;"


iterated : Bool -> Bool -> Int -> Int -> Int -> Int
iterated shift reverse dimension segments n =
  let
    index = if reverse then segments - n else n
    offset = (dimension // segments) * index
  in
    if shift then
      (dimension // 2) + (offset // 2)
    else
      (offset // 2)
