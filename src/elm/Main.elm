module Main exposing (..)

import Html exposing (..)
import Store.Main as Store
import App.Main as App


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Msg
    = StoreMsg Store.Msg
    | AppMsg App.Msg


type alias Model =
    { store : Store.Model
    , app : App.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( store, storeCmd ) =
            Store.init

        ( app, appCmd ) =
            App.init

        cmds =
            Cmd.batch
                [ Cmd.map StoreMsg storeCmd
                , Cmd.map AppMsg appCmd
                ]
    in
        ( Model store app, cmds )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StoreMsg storeMsg ->
            let
                ( store, cmd ) =
                    Store.update storeMsg model.store
            in
                ( { model | store = store }, Cmd.map StoreMsg cmd )

        AppMsg appMsg ->
            let
                ( app, appCmd, storeCmd ) =
                    App.update appMsg model.app

                cmds =
                    Cmd.batch
                        [ Cmd.map StoreMsg storeCmd
                        , Cmd.map AppMsg appCmd
                        ]
            in
                ( { model | app = app }, cmds )


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Global Header" ]
        , Html.map AppMsg (App.view model.store model.app)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
