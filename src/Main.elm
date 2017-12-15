module Main exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


type Msg
    = NoOp


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Quizboard" ]
        , div [ class "resultList" ] [ results model.teams ]
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
        , div [] [ totalScore team.scores ]
        ]


scoreList : List Score -> Html Msg
scoreList scores =
    ul [] (List.map resultLine scores)


resultLine : Score -> Html Msg
resultLine score =
    li [] [ text (toString score) ]


totalScore : List Score -> Html Msg
totalScore scores =
    div [] [ text (toString (List.sum scores)) ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
