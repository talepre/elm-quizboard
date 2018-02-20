module Models exposing (..)


initialModel : Model
initialModel =
    { teams = [], showAddTeamField = False, showAddScore = False, tempNewTeam = "" }


type alias Model =
    { teams : List Team
    , showAddTeamField : Bool
    , showAddScore : Bool
    , tempNewTeam : String
    }


type alias Team =
    { name : String
    , scores : List ScoreRecord
    , average : Score
    , total : Score
    }


type alias ScoreRecord =
    { date : Date
    , score : Score
    }


type alias Score =
    Int


type alias Date =
    String
