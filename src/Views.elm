module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ div [ class "currentWinnerBox box" ] [ currentWinner "HC Team 5" ]

        --, div [ class "resultListBoxes" ] [ results model.teams ]
        , div [ class "resultListBoxes" ] (List.map teamBox model.teams)
        , div [ class "accumulatedScoreBox box" ] [ accumulatedScores model.teams ]
        , div [ class "houseRulesBox box" ] [ houseRules [ "Quiz spilles hver ordinære arbeidsdag, i.e. dager man må ta seg fri", "Man må svare samme dag", "Alle må levere svar riktig dag", "Man må gi nøyaktige svar, ingen intervall" ] ]
        ]



--- CURRENT WINNER


currentWinner : String -> Html Msg
currentWinner teamName =
    h1 [] [ text teamName ]



--- ACCUMULATED SCORES


accumulatedScores : List Team -> Html Msg
accumulatedScores teams =
    div [] (List.map accumulatedScoreLine teams)


accumulatedScoreLine : Team -> Html Msg
accumulatedScoreLine team =
    div [] [ text team.name, text ": ", averageScore team.scores ]



--- HOUSE RULES


houseRules : List String -> Html Msg
houseRules rules =
    div [] (List.map ruleLine rules)


ruleLine : String -> Html Msg
ruleLine rule =
    div [] [ text rule ]



--- TEAM BOXES


results : List Team -> Html Msg
results teams =
    div [] (List.map teamBox teams)


teamBox : Team -> Html Msg
teamBox team =
    div [ class "teamBox box" ]
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
