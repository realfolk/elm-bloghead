module Bloghead.Post exposing
    ( Post
    , getAuthor
    , getBody
    , getPublishTime
    , getTitle
    , new
    , viewFullPost
    , viewPostListItem
    )

import Html exposing (Html)
import Html.Events as Events
import Time


type Post
    = Post
        { title : String
        , author : String
        , publishTime : Time.Posix
        , body : String
        }



-- CONSTRUCTORS


new : String -> String -> Time.Posix -> String -> Post
new title author publishTime body =
    Post
        { title = title
        , author = author
        , publishTime = publishTime
        , body = body
        }



-- ACCESSORS


getTitle : Post -> String
getTitle (Post { title }) =
    title


getAuthor : Post -> String
getAuthor (Post { author }) =
    author


getPublishTime : Post -> Time.Posix
getPublishTime (Post { publishTime }) =
    publishTime


getBody : Post -> String
getBody (Post { body }) =
    body



-- VIEWS


viewPostListItem : (Post -> msg) -> Post -> Html msg
viewPostListItem setActivePost post =
    Html.a
        [ Events.onClick (setActivePost post) ]
        [ Html.text (getTitle post ++ " by " ++ getAuthor post) ]


viewFullPost : Post -> Html msg
viewFullPost post =
    Html.div []
        [ Html.h3 [] [ Html.text <| getTitle post ]
        , Html.em [] [ Html.text <| getAuthor post ]
        , Html.div [] [ Html.text <| timeToString <| getPublishTime post ]
        , Html.div [] [ Html.text <| getBody post ]
        ]



-- INTERNAL HELPERS


timeToString : Time.Posix -> String
timeToString time =
    let
        year =
            Time.toYear Time.utc time

        month =
            case Time.toMonth Time.utc time of
                Time.Jan ->
                    "Jan"

                Time.Feb ->
                    "Feb"

                Time.Mar ->
                    "Mar"

                Time.Apr ->
                    "Apr"

                Time.May ->
                    "May"

                Time.Jun ->
                    "Jun"

                Time.Jul ->
                    "Jul"

                Time.Aug ->
                    "Aug"

                Time.Sep ->
                    "Sep"

                Time.Oct ->
                    "Oct"

                Time.Nov ->
                    "Nov"

                Time.Dec ->
                    "Dec"

        day =
            Time.toDay Time.utc time
    in
    month ++ " " ++ String.fromInt day ++ ", " ++ String.fromInt year
