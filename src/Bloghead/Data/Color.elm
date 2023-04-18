module Bloghead.Data.Color exposing (Channels, Color, Error(..), alpha50, black, blue, green, opaque, red, rgba, safeRGBA, setAlpha, toChannels, toCssColor, toHtml, transparent)

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
    RGBA <| makeBoundedChannels r g b a


type Error
    = InvalidRedChannel Int
    | InvalidGreenChannel Int
    | InvalidBlueChannel Int
    | InvalidAlphaChannel Float


safeRGBA : Int -> Int -> Int -> Float -> Result Error Color
safeRGBA r g b a =
    Result.map RGBA <| safeMakeChannels r g b a


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


setAlpha : Float -> Color -> Color
setAlpha alpha color =
    let
        channels =
            toChannels color
    in
    rgba channels.red channels.green channels.blue alpha


transparent : Color -> Color
transparent color =
    setAlpha 0 color


opaque : Color -> Color
opaque color =
    setAlpha 1 color


alpha50 : Color -> Color
alpha50 color =
    setAlpha 0.5 color



---- Internal


safeMakeChannels : Int -> Int -> Int -> Float -> Result Error Channels
safeMakeChannels r g b a =
    let
        validateColorChannel : (Int -> Error) -> Int -> Result Error Int
        validateColorChannel makeError n =
            if n < 0 || n > 255 then
                Err (makeError n)

            else
                Ok n

        validateAlphaChannel : (Float -> Error) -> Float -> Result Error Float
        validateAlphaChannel makeError n =
            if n < 0 || n > 1 then
                Err (makeError n)

            else
                Ok n
    in
    Result.map4
        Channels
        (validateColorChannel InvalidRedChannel r)
        (validateColorChannel InvalidGreenChannel g)
        (validateColorChannel InvalidBlueChannel b)
        (validateAlphaChannel InvalidAlphaChannel a)


makeBoundedChannels : Int -> Int -> Int -> Float -> Channels
makeBoundedChannels r g b a =
    let
        clampColorChannel =
            clamp 0 255

        clampAlphaChannel =
            clamp 0 1
    in
    Channels (clampColorChannel r) (clampColorChannel g) (clampColorChannel b) (clampAlphaChannel a)
