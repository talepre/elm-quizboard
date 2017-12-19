module Main exposing (..)

import Models exposing (..)
import Html exposing (..)
import Msgs exposing (..)
import Views exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
