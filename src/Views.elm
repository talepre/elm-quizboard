module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Quizboard" ]
        , div [] [ navbar model ]
        , div [ class "resultList" ] [ results model.teams ]
        ]


navbar : Model -> Html Msg
navbar model =
    div [] [ addTeam model ]


addTeam : Model -> Html Msg
addTeam model =
    div []
        [ addTeamButton
        , addScoreButton
        , if model.showAddTeamField then
            addTeamInputField
          else
            div [] []
        , if model.showAddScore then
            addScoreField
          else
            div [] []
        ]


addTeamButton : Html Msg
addTeamButton =
    div [ onClick Msgs.ToggleAddTeamField ] [ text "Add team" ]


addScoreButton : Html Msg
addScoreButton =
    div [ onClick Msgs.ToggleAddScoreButton ] [ text "Add score" ]


addTeamInputField : Html Msg
addTeamInputField =
    div []
        [ input [ onInput Msgs.AddTeam ] []
        , div [ onClick Msgs.SaveTeam ] [ text "Save team" ]
        ]


addScoreField : Html Msg
addScoreField =
    div [] [ text "Add score field, choose team and score 1-10" ]


results : List Team -> Html Msg
results teams =
    div [] (List.map teamBox teams)



-- TODO: Rename this function


teamBox : Team -> Html Msg
teamBox team =
    div []
        [ h2 [] [ text team.name ]
        , div [] [ scoreList team.scores ]
        , div [] [ totalScore team.total ]
        ]


scoreList : List ScoreRecord -> Html Msg
scoreList scores =
    ul [] (List.map resultLine scores)


resultLine : ScoreRecord -> Html Msg
resultLine scores =
    li [] [ text (toString scores.score) ]


totalScore : Score -> Html Msg
totalScore score =
    div [] [ text (toString (score)) ]