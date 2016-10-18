module Main exposing (..)

import Dict exposing (Dict)
import Navigation

import Form exposing (Form)
import Hop exposing (matchUrl)
import Hop.Types exposing (Location)

import Forms exposing (..)
import Routing.Config
import Models exposing (..)
import Updates exposing (..)
import Views exposing (..)


urlParser : Navigation.Parser ( Routing.Config.Route, Hop.Types.Location )
urlParser =
  Navigation.makeParser (.href >> matchUrl Routing.Config.config)


urlUpdate : ( Routing.Config.Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
  let
    _ = Debug.log "urlUpdate location" location
  in
    ( { model | route = route, location = location }, Cmd.none )


type alias Flags =
  { csrfToken : String
  }


init : Flags -> ( Routing.Config.Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init flags ( route, location ) =
  ( { statementDateForm = Form.initial [] validateStatementDate
    , publicServantForm = Form.initial [] validatePublicServant
    , landForms = Dict.fromList [(0, Form.initial [] validateLand)]
    , currentSection = 0
    , route = route
    , location = location
    , csrfToken = flags.csrfToken
    }
    , Cmd.none )


main : Program Flags
main = Navigation.programWithFlags urlParser
  { init = init
  , update = update
  , view = view
  , urlUpdate = urlUpdate
  , subscriptions = \_ -> Sub.none
  }
