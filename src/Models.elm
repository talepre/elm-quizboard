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
        , { name = "Team 5"
          , scores =
                [ { date = "DATO", score = 4 }
                , { date = "DATO", score = 5 }
                , { date = "DATO", score = 6 }
                ]
          }
        ]
    , showAddTeamField = False
    , showAddScore = False
    , tempNewTeam = ""
    , teamChosenForScore = Nothing
    , newChosenScore = Nothing
    , houseRules = [ "Quiz spilles hver ordinære arbeidsdag, i.e. dager man må ta seg fri", "Man må svare samme dag", "Alle må levere svar riktig dag", "Man må gi nøyaktige svar, ingen intervall" ]
    }


type alias Model =
    { teams : List Team
    , showAddTeamField : Bool
    , showAddScore : Bool
    , tempNewTeam : String
    , teamChosenForScore : Maybe Team
    , newChosenScore : Maybe Score
    , houseRules : List Rule
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


type alias Rule =
    String
