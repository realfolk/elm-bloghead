port module Bloghead.Database exposing
    ( Data
    , persist
    )

import Bloghead.Post exposing (Post)
import Json.Encode as Json


type alias Data =
    List Post


port persist : Json.Value -> Cmd msg
