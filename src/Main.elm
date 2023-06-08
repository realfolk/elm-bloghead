module Main exposing (main)

import Bloghead.Database as Db
import Bloghead.Post as Post exposing (Post)
import Browser
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
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
    , form : Form
    }


type alias Form =
    { title : String
    , author : String
    , body : String
    }


emptyForm : Form
emptyForm =
    Form "" "" ""


type Msg
    = SetActivePost Post
    | OnSubmitForm
    | OnCreatePost Post
    | OnTitleInput String
    | OnAuthorInput String
    | OnBodyInput String


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
      , form = emptyForm
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetActivePost post ->
            ( { model | activePost = Just post }, Cmd.none )

        OnSubmitForm ->
            ( model
            , Post.newWithCurrentPublishTime model.form.title model.form.author model.form.body
                |> Cmd.map OnCreatePost
            )

        OnCreatePost post ->
            let
                newPosts =
                    post :: model.posts
            in
            ( { model
                | posts = newPosts
                , form = emptyForm
              }
            , Db.persist (Db.fromPosts newPosts)
            )

        OnTitleInput newTitle ->
            let
                form =
                    model.form

                newForm =
                    { form | title = newTitle }
            in
            ( { model | form = newForm }, Cmd.none )

        OnAuthorInput newAuthor ->
            let
                form =
                    model.form

                newForm =
                    { form | author = newAuthor }
            in
            ( { model | form = newForm }, Cmd.none )

        OnBodyInput newBody ->
            let
                form =
                    model.form

                newForm =
                    { form | body = newBody }
            in
            ( { model | form = newForm }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div
        [ Attr.style "padding" "48px 32px"
        ]
        [ viewCreatePostForm model.form
        , viewPostList model
        , viewActivePost model.activePost
        ]


viewCreatePostForm : Form -> Html Msg
viewCreatePostForm form =
    Html.form
        [ Events.onSubmit OnSubmitForm
        , Attr.style "display" "flex"
        , Attr.style "flex-flow" "column nowrap"
        , Attr.style "align-items" "flex-start"
        ]
        [ Html.div [] [ Html.text "Title" ]
        , Html.input [ Attr.type_ "text", Attr.value form.title, Events.onInput OnTitleInput ] []
        , Html.div [ Attr.style "margin-top" "24px" ] [ Html.text "Author" ]
        , Html.input [ Attr.type_ "text", Attr.value form.author, Events.onInput OnAuthorInput ] []
        , Html.div [ Attr.style "margin-top" "24px" ] [ Html.text "Post Body" ]
        , Html.textarea [ Attr.value form.body, Events.onInput OnBodyInput ] []
        , Html.button [ Attr.style "margin-top" "24px", Attr.type_ "submit" ] [ Html.text "Create Post" ]
        ]
        |> List.singleton
        |> viewSection


viewPostList : Model -> Html Msg
viewPostList model =
    model.posts
        |> List.map
            (\post -> Post.viewPostListItem (Just post == model.activePost) SetActivePost post)
        |> List.intersperse (Html.div [ Attr.style "height" "18px" ] [])
        |> viewSection


viewActivePost : Maybe Post -> Html msg
viewActivePost activePost =
    activePost
        |> Maybe.map Post.viewFullPost
        |> Maybe.withDefault (Html.text "No post selected.")
        |> List.singleton
        |> viewSection


viewSection : List (Html msg) -> Html msg
viewSection =
    Html.div
        [ Attr.style "display" "flex"
        , Attr.style "flex-flow" "column nowrap"
        , Attr.style "align-items" "flex-start"
        , Attr.style "margin-bottom" "48px"
        , Attr.style "padding" "32px"
        , Attr.style "border" "1px solid silver"
        , Attr.style "border-radius" "8px"
        ]
