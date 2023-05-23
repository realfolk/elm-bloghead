port module Bloghead.Database exposing
    ( Data
    , decode
    , encode
    , fromPosts
    , getPosts
    , persist
    )

import Bloghead.Post as Post exposing (Post)
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value)


type Data
    = Data (List Post)



-- CONSTRUCTORS


fromPosts : List Post -> Data
fromPosts =
    Data


decode : Value -> Maybe Data
decode json =
    Decode.decodeValue (Decode.list Post.decoder) json
        |> Result.toMaybe
        |> Maybe.map Data



-- CONVERTERS


encode : Data -> Value
encode (Data posts) =
    Encode.list Post.encode posts



-- ACCESSORS


getPosts : Data -> List Post
getPosts (Data posts) =
    posts



-- PORTS


persist : Data -> Cmd msg
persist =
    encode >> persistJson


port persistJson : Value -> Cmd msg
