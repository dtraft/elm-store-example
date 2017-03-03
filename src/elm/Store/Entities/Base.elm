module Store.Entities.Base exposing (..)

import Http
import Dict


type alias Post =
    { userId : Int
    , id : Int
    , title : String
    , body : String
    }


type alias Slice a =
    { a | isSaving : Bool, isLoading : Bool }


type alias Model =
    { posts : Slice { entities : Dict.Dict Int Post } }


type alias Normalized =
    { posts : Maybe (Dict.Dict Int Post) }


type Msg
    = Response (Result Http.Error Normalized)
