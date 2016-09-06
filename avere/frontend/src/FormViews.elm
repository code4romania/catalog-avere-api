module FormViews exposing (..)

import Html exposing (Html, div)
import Html.App as Html

import Form exposing (Form)

import Updates exposing (Msg(..), FormName(..), IndexedFormName(..))
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
    Html.map (FormMsg StatementDateForm) html


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
    Html.map (FormMsg PublicServantForm) html


landFormView : Int -> Form () Land -> Html Msg
landFormView formId form =
  let
    location = Form.getFieldAsString "location" form
    category = Form.getFieldAsString "category" form
    year_acquired = Form.getFieldAsString "year_acquired" form
    area = Form.getFieldAsString "area" form
    share = Form.getFieldAsString "share" form
    method_acquired = Form.getFieldAsString "method_acquired" form
    owner = Form.getFieldAsString "owner" form
    categoryOptions =
      [ ("1", "agricol")
      , ("2", "forestier")
      , ("3", "intravilan")
      , ("4", "luciu apă")
      , ("5", "alte categorii de terenuri extravilane")
      ]
    html = div []
             [ textInputWidget "Adresa sau zona: " location
             , selectInputWidget  "Categoria: " categoryOptions category
             , textInputWidget "Anul dobândirii: " year_acquired
             , textInputWidget "Suprafața (mp): " area
             , textInputWidget "Cota-parte (%): " share
             , textInputWidget "Modul de dobândire: " method_acquired
             , textInputWidget "Titularul: " owner
             ]
    in
      Html.map (IndexedFormMsg LandForm formId) html
