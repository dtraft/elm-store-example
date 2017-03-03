module App.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Store.Main as Store
import Store.Entities.Post as Post


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | LoadPosts


update : Msg -> Model -> ( Model, Cmd Msg, Cmd Store.Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none, Cmd.none )

        LoadPosts ->
            ( model, Cmd.none, Store.mapEntityMsg Post.getList )



-- VIEW


view : Store.Model -> Model -> Html Msg
view store model =
    let
        posts =
            Store.selectEntities Post.selectList store
    in
        div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div [] [ text (toString model) ]
            , button [ onClick Increment ] [ text "+" ]
            , button [ onClick LoadPosts ] [ text "Get me some posts" ]
            , list posts
            ]


list : Post.Collection -> Html Msg
list posts =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "userId" ]
                    , th [] [ text "id" ]
                    , th [] [ text "title" ]
                    , th [] [ text "body" ]
                    ]
                ]
            , tbody [] (List.map row posts)
            ]
        ]


row : Post.Model -> Html Msg
row post =
    tr []
        [ td [] [ text (toString post.userId) ]
        , td [] [ text (toString post.id) ]
        , td [] [ text post.title ]
        , td [] [ text post.body ]
        ]
