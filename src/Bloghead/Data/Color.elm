module Bloghead.Data.Color exposing (Channels, Color, black, blue, green, pct50, red, rgba, toChannels, toCssColor, toHtml)

import Html exposing (Html)
import Html.Attributes as Attributes



-- Color


type Color
    = RGBA Channels
    | Red
    | Blue


type alias Channels =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }



---- Constructors


rgba : Int -> Int -> Int -> Float -> Color
rgba r g b a =
    RGBA (makeBoundedChannels r g b a)


black : Color
black =
    rgba 0 0 0 1


red : Color
red =
    rgba 255 0 0 1


green : Color
green =
    rgba 0 255 0 1


blue : Color
blue =
    rgba 0 0 255 1



---- Converters


toChannels : Color -> Channels
toChannels color =
    case color of
        RGBA channels ->
            channels

        Red ->
            makeBoundedChannels 255 0 0 1

        Blue ->
            makeBoundedChannels 0 0 255 1


toHtml : Color -> Html msg
toHtml color =
    let
        cssColor =
            toCssColor color
    in
    Html.div
        [ Attributes.style "background-color" cssColor
        , Attributes.style "border-radius" "4px"
        , Attributes.style "padding" "8px 16px"
        , Attributes.style "font-family" "sans-serif"
        , Attributes.style "font-weight" "700"
        ]
        [ Html.text cssColor ]


toCssColor : Color -> String
toCssColor color =
    let
        channels =
            toChannels color
    in
    String.concat
        [ "rgba("
        , String.fromInt channels.red
        , ","
        , String.fromInt channels.green
        , ","
        , String.fromInt channels.blue
        , ","
        , String.fromFloat channels.alpha
        , ")"
        ]



---- Modifiers


pct50 : Color -> Color
pct50 color =
    let
        channels =
            toChannels color
    in
    rgba channels.red channels.green channels.blue channels.alpha



---- Internal


makeBoundedChannels : Int -> Int -> Int -> Float -> Channels
makeBoundedChannels r g b a =
    let
        coerceChannel n =
            if n < 0 then
                0

            else if n > 255 then
                255

            else
                n

        coerceOpacity o =
            if o < 0 then
                0

            else if o > 1 then
                1

            else
                o
    in
    { red = coerceChannel r
    , green = coerceChannel g
    , blue = coerceChannel b
    , alpha = coerceOpacity a
    }
