module Bloghead.Api exposing (getPosts, posts)

import Bloghead.Post as Post exposing (Post)
import Task
import Time


getPosts : Cmd (List Post)
getPosts =
    Task.succeed posts
        |> Task.perform identity



-- DATA


posts : List Post
posts =
    [ Post.new
        "This is the first post."
        "Mary Nara"
        (Time.millisToPosix 0)
        "**This is the body of the first post.**"
    , Post.new
        "This is the second post."
        "Beef Sausage"
        (Time.millisToPosix 100000)
        "**This is the body of the second post.**"
    , Post.new
        "This is the third post."
        "Papa Sta"
        (Time.millisToPosix 200000)
        "**This is the body of the third post.**"
    ]
