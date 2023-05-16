module Main exposing (main)

import Bloghead.Api as Api
import Bloghead.Post as Post exposing (Post)
import Browser
import Html exposing (Html)
import Html.Attributes as Attr


type alias Flags =
    String


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { posts : List Post
    , activePost : Maybe Post
    }


type Msg
    = GotPosts (List Post)
    | SetActivePost Post


init : Flags -> ( Model, Cmd Msg )
init rawDbString =
    ( { posts = []
      , activePost = Nothing
      }
    , Cmd.map GotPosts Api.getPosts
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotPosts posts ->
            ( { model | posts = posts }, Cmd.none )

        SetActivePost post ->
            ( { model | activePost = Just post }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ Attr.style "padding" "48px 32px"
        ]
        [ Html.div
            [ Attr.style "display" "flex"
            , Attr.style "flex-flow" "column nowrap"
            , Attr.style "align-items" "flex-start"
            , Attr.style "padding" "32px"
            , Attr.style "border" "1px solid silver"
            , Attr.style "border-radius" "8px"
            ]
            (model.posts
                |> List.map
                    (\post -> Post.viewPostListItem (Just post == model.activePost) SetActivePost post)
                |> List.intersperse (Html.div [ Attr.style "height" "18px" ] [])
            )
        , model.activePost
            |> Maybe.map Post.viewFullPost
            |> Maybe.withDefault (Html.text "No post selected.")
            |> List.singleton
            |> Html.div
                [ Attr.style "margin-top" "48px"
                , Attr.style "padding" "32px"
                , Attr.style "border" "1px solid silver"
                , Attr.style "border-radius" "8px"
                ]
        ]
