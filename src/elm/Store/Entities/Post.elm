module Store.Entities.Post exposing (..)

import Http
import Json.Decode exposing (int, string, list, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Dict
import Store.Entities.Base as Base
import Store.Entities.Base exposing (Msg(..))


type alias Model =
    Base.Post


type alias Collection =
    List Model


type alias Entities =
    Dict.Dict Int Model


decodeCollection : Decoder Collection
decodeCollection =
    list decodeObject


decodeObject : Decoder Base.Post
decodeObject =
    decode Base.Post
        |> required "userId" int
        |> required "id" int
        |> required "title" string
        |> required "body" string


type Msg
    = LoadAll
    | BaseMsg Base.Msg


update : Msg -> Cmd Base.Msg
update msg =
    case msg of
        LoadAll ->
            getList

        BaseMsg baseMsg ->
            case baseMsg of
                Response (Ok normalized) ->
                    Cmd.none

                Response (Err error) ->
                    Cmd.none


getList : Cmd Base.Msg
getList =
    Http.send responseFromList <|
        Http.get "https://jsonplaceholder.typicode.com/posts" decodeCollection


responseFromList : Result Http.Error Collection -> Base.Msg
responseFromList result =
    let
        response =
            result
                |> Result.map (\posts -> normalizeList posts)
    in
        Response response


normalizeList : Collection -> Base.Normalized
normalizeList posts =
    let
        normalizedPosts =
            posts
                |> List.map (\post -> ( post.id, post ))
                |> Dict.fromList
    in
        { posts = Just normalizedPosts }



-- Selectors


selectList : Base.Model -> Collection
selectList entities =
    entities.posts.entities
        |> Dict.values
