module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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


init : ( Routing.Config.Route, Hop.Types.Location) -> ( Model, Cmd Msg )
init ( route, location ) =
  ( { statementDateForm = Form.initial [] validateStatementDate
    , publicServantForm = Form.initial [] validatePublicServant
    , currentSection = 0
    , route = route
    , location = location
    }
    , Cmd.none )


app = Navigation.program urlParser
  { init = init
  , update = update
  , view = view
  , urlUpdate = urlUpdate
  , subscriptions = \_ -> Sub.none
  }

main = app
