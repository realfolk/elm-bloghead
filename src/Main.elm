module Main exposing (main)

import Bloghead.Database as Db
import Bloghead.Post as Post exposing (Post)
import Browser
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Encode as Json


type alias Flags =
    Json.Value


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
    = SetActivePost Post
    | PersistData


init : Flags -> ( Model, Cmd Msg )
init json =
    let
        posts =
            Db.decode json
                |> Maybe.map Db.getPosts
                |> Maybe.withDefault []
    in
    ( { posts = posts
      , activePost = Nothing
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetActivePost post ->
            ( { model | activePost = Just post }, Cmd.none )

        PersistData ->
            ( model
            , Db.persist (Db.fromPosts model.posts)
            )


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
