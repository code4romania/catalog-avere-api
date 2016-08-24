module Models exposing (..)

import Date exposing (Date)

import Form exposing (Form)


type alias PublicServant =
  { first_name : String
  , last_name : String
  , position : String
  , position_location : String
  }


type alias StatementDate =
  { date : Date
  }


type alias Statement =
  { date : StatementDate
  , public_servant : PublicServant
  }


type alias Model =
  { statementDateForm : Form () StatementDate
  , publicServantForm : Form () PublicServant
  , currentSection : Int
  }
