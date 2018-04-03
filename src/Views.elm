module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ div [ class "left-col" ]
            [ div [ class "bg-pink box" ] [ accumulatedScoresHeader, accumulatedScores model.teams ]
            , div [ class "bg-limegreen box" ] [ currentWinnerHeader, currentWinner "HC Team 5" ]
            , div [ class "bg-blue box" ] [ houseRulesHeader, houseRules model.houseRules ]
            ]
        , div [ class "resultListBoxes" ] (List.map teamBox model.teams)
        ]



--- CURRENT WINNER


currentWinnerHeader : Html Msg
currentWinnerHeader =
    h1 [ class "bg-dark-limegreen header" ] [ text "Forrige måneds vinner" ]


currentWinner : String -> Html Msg
currentWinner teamName =
    div [] [ text teamName ]



--- ACCUMULATED SCORES


accumulatedScoresHeader : Html Msg
accumulatedScoresHeader =
    h1 [ class "bg-dark-pink header" ] [ text "Stilling" ]


accumulatedScores : List Team -> Html Msg
accumulatedScores teams =
    ol [] (List.map accumulatedScoreLine teams)


accumulatedScoreLine : Team -> Html Msg
accumulatedScoreLine team =
    li [ class "lists" ] [ text team.name, text ": ", averageScore team.scores ]



--- HOUSE RULES


houseRulesHeader : Html Msg
houseRulesHeader =
    h1 [ class "bg-dark-blue header" ] [ text "Husregler" ]


houseRules : List String -> Html Msg
houseRules rules =
    ol [] (List.map ruleLine rules)


ruleLine : String -> Html Msg
ruleLine rule =
    li [ class "lists" ] [ text rule ]



--- TEAM BOXES


results : List Team -> Html Msg
results teams =
    div [] (List.map teamBox teams)


teamBox : Team -> Html Msg
teamBox team =
    div [ class "bg-sea-green box" ]
        [ h1 [ class "header bg-dark-sea-green" ] [ text team.name ]
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
