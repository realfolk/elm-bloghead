module Bloghead.Route exposing (Route(..), fromUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>))



-- Routes
-- 1. List of Posts (Home)  /
-- 2. View a Single Post    /post/:id
-- 3. Create a Post         /create
-- 4. Not Found             ???


type Route
    = Posts
    | ViewPost String
    | CreatePost
    | NotFound Url



-- Constructors


fromUrl : Url -> Route
fromUrl url =
    let
        parser =
            Parser.oneOf
                [ Parser.map Posts Parser.top
                , Parser.map CreatePost (Parser.s "create")
                , Parser.map ViewPost (Parser.s "post" </> Parser.string)
                ]
    in
    Parser.parse parser url
        |> Maybe.withDefault (NotFound url)
