module Main exposing (main)

import Bloghead.Api as Api
import Bloghead.Post as Post exposing (Post)
import Browser
import Html exposing (Html)


main : Program () Model Msg
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


init : flags -> ( Model, Cmd Msg )
init _ =
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
    Html.div []
        [ Html.div []
            (List.map (Post.viewPostListItem SetActivePost) model.posts)
        , model.activePost
            |> Maybe.map Post.viewFullPost
            |> Maybe.withDefault (Html.text "No post selected.")
        ]
