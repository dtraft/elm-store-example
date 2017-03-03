module Store.Entities exposing (..)

import Dict
import Store.Entities.Base as Base
import Store.Entities.Base exposing (Msg(..), Normalized)
import Store.Entities.Post as Post


type alias Model =
    Base.Model


type Msg
    = PostRequest Post.Msg
    | BaseMsg Base.Msg
    | NoOp


init : ( Model, Cmd Msg )
init =
    let
        model =
            { posts = { entities = Dict.empty, isSaving = False, isLoading = False } }
    in
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PostRequest postMsg ->
            let
                cmd =
                    Post.update postMsg
            in
                ( model, Cmd.map BaseMsg cmd )

        BaseMsg baseMsg ->
            case baseMsg of
                Response (Ok normalized) ->
                    let
                        normalize =
                            mergeEntities normalized

                        posts =
                            model.posts

                        newPosts =
                            { posts | entities = normalize posts.entities .posts }
                    in
                        ( { model | posts = newPosts }, Cmd.none )

                Response (Err error) ->
                    Debug.log (toString error) ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


mergeEntities : Normalized -> Dict.Dict Int a -> (Normalized -> Maybe (Dict.Dict Int a)) -> Dict.Dict Int a
mergeEntities normalized current slice =
    let
        update =
            slice normalized
    in
        case update of
            Just entities ->
                current
                    |> Dict.union entities

            Nothing ->
                current
