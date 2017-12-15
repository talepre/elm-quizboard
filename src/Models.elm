module Models exposing (..)


initialModel : Model
initialModel =
    { teams = [ { name = "Team 1", scores = [ 2, 3 ] }, { name = "Team 5", scores = [ 7, 8 ] } ] }


type alias Model =
    { teams : List Team
    }


type alias Team =
    { name : String
    , scores : List Score
    }


type alias Score =
    Int
