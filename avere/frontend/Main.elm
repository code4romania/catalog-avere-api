module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Form exposing (Form)

import Forms exposing (..)
import Models exposing (..)
import Updates exposing (..)
import Views exposing (..)


init : ( Model, Cmd Msg )
init =
  ( { statementDateForm = Form.initial [] validateStatementDate
    , publicServantForm = Form.initial [] validatePublicServant
    , currentSection = 0
    }
    , Cmd.none )


app = Html.program
  { init = init
  , update = update
  , view = view
  , subscriptions = \_ -> Sub.none
  }

main = app
