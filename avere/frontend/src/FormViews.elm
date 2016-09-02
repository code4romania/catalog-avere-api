module FormViews exposing (..)

import Html exposing (Html, div)
import Html.App as Html

import Form exposing (Form)

import Updates exposing (Msg(..))
import Models exposing (Model, StatementDate, PublicServant, Land)
import FormWidgets exposing (textInputWidget, selectInputWidget)


statementFormView : Form () StatementDate -> Html Msg
statementFormView form =
  let
    date = Form.getFieldAsString "date" form
    html = div []
             [ textInputWidget "Data declarației: " date
             ]
  in
    Html.map (FormMsg "statementForm") html


publicServantFormView : Form () PublicServant -> Html Msg
publicServantFormView form =
  let
    first_name = Form.getFieldAsString "first_name" form
    last_name = Form.getFieldAsString "last_name" form
    position = Form.getFieldAsString "position" form
    position_location = Form.getFieldAsString "position_location" form
    html = div []
             [ textInputWidget "Prenume: " first_name
             , textInputWidget "Nume: " last_name
             , textInputWidget "Funcție: " position
             , textInputWidget "Locul funcției: " position_location
             ]
  in
    Html.map (FormMsg "publicServantForm") html

