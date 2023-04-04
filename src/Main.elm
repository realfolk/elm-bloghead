module Main exposing (main)

import Bloghead.Data.Color as Color exposing (Color)
import Html exposing (Html)


colors : List Color
colors =
    [ Color.red
    , Color.green
    , Color.blue
    , Color.black
    , Color.rgba 99 88 12 1
    , Color.rgba 167 39 199 1
    ]


main : Html msg
main =
    Html.div [] (List.map Color.toHtml colors)
