module SectionViews exposing (sections)

import Array exposing (Array)
import Dict exposing (Dict)
import Html exposing (Html, section)

import Updates exposing (Msg(..))
import Models exposing (Model)
import FormViews exposing (..)


sections : Array (Model -> Html Msg)
sections = Array.fromList
 [ section1
 , section2
 ]


section1 : Model -> Html Msg
section1 model =
  section []
    [ statementFormView model.statementDateForm
    , publicServantFormView model.publicServantForm
    ]


section2 : Model -> Html Msg
section2 model =
  section []
    <| Dict.values <| Dict.map landFormView model.landForms

