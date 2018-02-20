module Msgs exposing (..)

import Models exposing (..)


type Msg
    = NoOp
    | ToggleAddTeamField
    | ToggleAddScoreButton
    | AddTeam String
    | SaveTeam


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleAddTeamField ->
            let
                toggled =
                    not model.showAddTeamField
            in
                ( { model | showAddTeamField = toggled }, Cmd.none )

        ToggleAddScoreButton ->
            let
                toggled =
                    not model.showAddScore
            in
                ( { model | showAddScore = toggled }, Cmd.none )

        AddTeam teamName ->
            ( { model | tempNewTeam = teamName }, Cmd.none )

        SaveTeam ->
            let
                newTeam =
                    Team model.tempNewTeam [] 0 0

                newTeams =
                    newTeam :: model.teams
            in
                ( { model | teams = newTeams, showAddTeamField = False }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
