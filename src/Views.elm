module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "header" ] [ text "Quizboard" ]
        , div [ class "navbar" ] [ navbar model ]
        , div [ class "configbar " ] [ configbar model ]
        , div [ class "resultList" ] [ results model.teams ]
        ]



--- NAVBAR


navbar : Model -> Html Msg
navbar model =
    div [] [ addTeam model ]


addTeam : Model -> Html Msg
addTeam model =
    div []
        [ addTeamButton
        , addScoreButton
        ]


addTeamButton : Html Msg
addTeamButton =
    div [ onClick Msgs.ToggleAddTeamField, class "navButton" ] [ text "Add team" ]


addScoreButton : Html Msg
addScoreButton =
    div [ onClick Msgs.ToggleAddScoreButton, class "navButton" ] [ text "Add score" ]



--- CONFIGBAR


configbar : Model -> Html Msg
configbar model =
    div [ class "configbar" ]
        [ if model.showAddTeamField then
            addTeamInputField
          else
            div [] []
        , if model.showAddScore then
            addScoreField model
          else
            div [] []
        ]


addTeamInputField : Html Msg
addTeamInputField =
    div []
        [ input [ onInput Msgs.AddTeam ] []
        , div [ onClick Msgs.SaveTeam, class "button" ] [ text "Save team" ]
        ]


addScoreField : Model -> Html Msg
addScoreField model =
    div []
        [ chooseTeamForScore model
        , chooseScore model.newChosenScore
        , saveScoreButton
        ]


chooseTeamForScore : Model -> Html Msg
chooseTeamForScore model =
    div [] (List.map (teamButton model.teamChosenForScore) model.teams)


teamButton : Maybe Team -> Team -> Html Msg
teamButton maybeChosenTeam team =
    case maybeChosenTeam of
        Just chosenTeam ->
            if (chosenTeam.name == team.name) then
                div [ class "chosenButton", onClick (Msgs.TeamForScoreChosen team) ] [ text team.name ]
            else
                div [ class "button", onClick (Msgs.TeamForScoreChosen team) ] [ text team.name ]

        Nothing ->
            div [ class "button", onClick (Msgs.TeamForScoreChosen team) ] [ text team.name ]


chooseScore : Maybe Score -> Html Msg
chooseScore maybeChosenScore =
    div [] (List.map (scoreButton maybeChosenScore) [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ])


scoreButton : Maybe Score -> Score -> Html Msg
scoreButton maybeChosenScore score =
    case maybeChosenScore of
        Just chosenScore ->
            if (score == chosenScore) then
                div [ class "chosenButton", onClick (Msgs.NewChosenScore score) ] [ text (toString score) ]
            else
                div [ class "button", onClick (Msgs.NewChosenScore score) ] [ text (toString score) ]

        Nothing ->
            div [ class "button", onClick (Msgs.NewChosenScore score) ] [ text (toString score) ]


saveScoreButton : Html Msg
saveScoreButton =
    div [ class "button", onClick (Msgs.SaveScore) ] [ text "Save" ]



--- TEAM BOXES


results : List Team -> Html Msg
results teams =
    div [] (List.map teamBox teams)


teamBox : Team -> Html Msg
teamBox team =
    div [ class "teambox" ]
        [ h2 [] [ text team.name ]
        , div [] [ scoreList team.scores ]
        , div [] [ text "Total: ", totalScore team.scores ]
        , div [] [ text "Average: ", averageScore team.scores ]
        ]


scoreList : List ScoreRecord -> Html Msg
scoreList scores =
    ul [] (List.map resultLine scores)


resultLine : ScoreRecord -> Html Msg
resultLine scores =
    li [] [ text (toString scores.score) ]


averageScore : List ScoreRecord -> Html Msg
averageScore scores =
    scores
        |> List.map .score
        |> List.sum
        |> toFloat
        |> (\a -> a / (toFloat (List.length scores)))
        |> toString
        |> text


totalScore : List ScoreRecord -> Html Msg
totalScore scores =
    scores
        |> List.map .score
        |> List.sum
        |> toString
        |> text
