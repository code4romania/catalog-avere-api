module Models exposing (..)

import Date exposing (Date)
import Dict exposing (Dict)

import Hop.Types exposing (Location)

import Form exposing (Form)
import Routing.Config exposing (Route)


type alias StatementDate =
  { date : Date
  }


type alias PublicServant =
  { first_name : String
  , last_name : String
  , position : String
  , position_location : String
  }


type alias Land =
  { location : String
  , category : Int
  , year_acquired : Int
  , area : Float
  , share : Int
  , method_acquired : String
  , owner : String
  }


type alias Statement =
  { date : StatementDate
  , public_servant : PublicServant
  }


type alias Model =
  { statementDateForm : Form () StatementDate
  , publicServantForm : Form () PublicServant
  , landForms : Dict Int (Form () Land)
  , currentSection : Int
  , location : Location
  , route : Route
  }
