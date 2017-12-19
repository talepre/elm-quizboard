module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msgs exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Quizboard" ]
        , div [] [ navbar ]
        , div [ class "resultList" ] [ results model.teams ]
        ]


navbar : Html Msg
navbar =
    div [] [ addTeamButton ]


addTeamButton : Html Msg
addTeamButton =
    div [] []


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
