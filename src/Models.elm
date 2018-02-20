module Models exposing (..)


initialModel : Model
initialModel =
    { teams =
        [ { name = "Team 1"
          , scores =
                [ { date = "DATO", score = 2 }
                , { date = "DATO", score = 3 }
                , { date = "DATO", score = 4 }
                ]
          }
        ]
    , showAddTeamField = False
    , showAddScore = False
    , tempNewTeam = ""
    }


type alias Model =
    { teams : List Team
    , showAddTeamField : Bool
    , showAddScore : Bool
    , tempNewTeam : String
    }


type alias Team =
    { name : String
    , scores : List ScoreRecord
    }


type alias ScoreRecord =
    { date : Date
    , score : Score
    }


type alias Score =
    Int


type alias Date =
    String
