module Main exposing (init, main)

import Browser exposing (..)
import Models exposing (..)
import Msgs exposing (..)
import Views exposing (..)


init : Int -> ( Model, Cmd Msg )
init number =
    ( initialModel, Cmd.none )


main : Program Int Model Msg
main =
    element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
