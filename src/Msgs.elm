module Msgs exposing (Msg(..), subscriptions, update)

import Models exposing (..)


type Msg
    = NoOp
    | ToggleAddTeamField
    | ToggleAddScoreButton
    | AddTeam String
    | SaveTeam
    | TeamForScoreChosen Team
    | NewChosenScore Int
    | SaveScore


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
                    Team model.tempNewTeam []

                newTeams =
                    newTeam :: model.teams
            in
            ( { model | teams = newTeams, showAddTeamField = False }, Cmd.none )

        TeamForScoreChosen team ->
            ( { model | teamChosenForScore = Just team }, Cmd.none )

        NewChosenScore score ->
            ( { model | newChosenScore = Just score }, Cmd.none )

        SaveScore ->
            case model.teamChosenForScore of
                Just chosenTeam ->
                    case model.newChosenScore of
                        Just chosenScore ->
                            let
                                updatedTeams =
                                    List.map
                                        (\team ->
                                            if team.name == chosenTeam.name then
                                                { team | scores = { date = "DATE", score = chosenScore } :: team.scores }

                                            else
                                                team
                                        )
                                        model.teams
                            in
                            ( { model
                                | newChosenScore = Nothing
                                , teamChosenForScore = Nothing
                                , showAddScore = False
                                , teams = updatedTeams
                              }
                            , Cmd.none
                            )

                        Nothing ->
                            ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
