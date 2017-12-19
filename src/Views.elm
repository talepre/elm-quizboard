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
        , if model.showAddTeamField then
            addTeamInputField
          else
            div [] []
        ]


addTeamButton : Html Msg
addTeamButton =
    div [ onClick Msgs.ToggleAddTeamField ] [ text "Add team" ]


addTeamInputField : Html Msg
addTeamInputField =
    div []
        [ input [ onInput Msgs.AddTeam ] []
        , div [ onClick Msgs.SaveTeam ] [ text "Save team" ]
        ]


results : List Team -> Html Msg
results teams =
    div [] (List.map teamBox teams)



-- TODO: Rename this function


teamBox : Team -> Html Msg
teamBox team =
    div []
        [ h2 [] [ text team.name ]
        , div [] [ scoreList team.scores ]
        , div [] [text "Total: ", totalScore team.scores ]
        , div [] [text "Average: ", averageScore team.scores ]
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
    |> (\a -> a/(toFloat (List.length scores)))
    |> toString
    |> text

totalScore : List ScoreRecord -> Html Msg
totalScore scores =
    scores
    |> List.map .score
    |> List.sum
    |> toString
    |> text
