module Models exposing (..)

import Date exposing (Date)

import Hop.Types exposing (Location)

import Form exposing (Form)
import Routing.Config exposing (Route)


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
  , location : Location
  , route : Route
  }
