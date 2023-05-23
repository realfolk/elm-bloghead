module Bloghead.Post exposing
    ( Post
    , decoder
    , encode
    , getAuthor
    , getBody
    , getPublishTime
    , getTitle
    , new
    , viewFullPost
    , viewPostListItem
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Markdown
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


decoder : Decoder Post
decoder =
    let
        posixDecoder =
            Decode.map Time.millisToPosix Decode.int
    in
    Decode.map4
        new
        Decode.string
        Decode.string
        posixDecoder
        Decode.string



-- CONVERTERS


encode : Post -> Value
encode (Post post) =
    Encode.object
        [ ( "title", Encode.string post.title )
        , ( "author", Encode.string post.author )
        , ( "publishTime", Encode.int <| Time.posixToMillis post.publishTime )
        , ( "body", Encode.string post.body )
        ]



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


viewPostListItem : Bool -> (Post -> msg) -> Post -> Html msg
viewPostListItem isActivePost setActivePost post =
    let
        styleAttrs =
            List.concat
                [ [ Attr.style "padding-bottom" "4px"
                  , Attr.style "border-bottom-size" "2px"
                  , Attr.style "border-bottom-style" "solid"
                  ]
                , if isActivePost then
                    [ Attr.style "border-color" "tomato"
                    , Attr.style "color" "tomato"
                    ]

                  else
                    [ Attr.style "border-color" "transparent"
                    , Attr.style "cursor" "pointer"
                    , Attr.style "color" "blue"
                    ]
                ]
    in
    Html.a
        (Events.onClick (setActivePost post) :: styleAttrs)
        [ Html.text (getTitle post ++ " by " ++ getAuthor post) ]


viewFullPost : Post -> Html msg
viewFullPost post =
    Html.div []
        [ Html.h3 [] [ Html.text <| getTitle post ]
        , Html.em [] [ Html.text <| getAuthor post ]
        , Html.div [] [ Html.text <| timeToString <| getPublishTime post ]
        , Html.div [] [ Markdown.toHtml [] <| getBody post ]
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
