module Store.Main exposing (..)

import Store.Entities as Entities
import Store.Entities exposing (Msg(BaseMsg))
import Store.Entities.Base as EntityBase


type alias Model =
    { entities : Entities.Model }


type Msg
    = EntitiesMsg Entities.Msg


init : ( Model, Cmd Msg )
init =
    let
        ( entities, cmd ) =
            Entities.init
    in
        ( { entities = entities }, Cmd.map EntitiesMsg cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EntitiesMsg subMsg ->
            let
                ( newEntities, cmds ) =
                    Entities.update subMsg model.entities
            in
                ( { model | entities = newEntities }, Cmd.map EntitiesMsg cmds )


mapEntityMsg : Cmd EntityBase.Msg -> Cmd Msg
mapEntityMsg cmd =
    Cmd.map EntitiesMsg (Cmd.map BaseMsg cmd)



-- HelperSelectors


selectEntities : (Entities.Model -> a) -> Model -> a
selectEntities selector model =
    selector model.entities
