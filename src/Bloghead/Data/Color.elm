module Bloghead.Data.Color exposing (Channels, Color, black, blue, getChannels, green, pct50, red, rgba)

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



---- Modifiers


pct50 : Color -> Color
pct50 color =
    let
        channels =
            getChannels color
    in
    rgba channels.red channels.green channels.blue channels.alpha



---- Accessors


getChannels : Color -> Channels
getChannels color =
    case color of
        RGBA channels ->
            channels

        Red ->
            makeBoundedChannels 255 0 0 1

        Blue ->
            makeBoundedChannels 0 0 255 1



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
