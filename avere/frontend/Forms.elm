module Forms exposing (validateStatementDate
                     , validatePublicServant)

import Form exposing (Form)
import Form.Validate as Validate exposing (..)
import Form.Input as Input

import Models exposing (..)


validateStatementDate : Validation () StatementDate
validateStatementDate =
  form1 StatementDate
    (get "date" date)


validatePublicServant : Validation () PublicServant
validatePublicServant =
  form4 PublicServant
    (get "first_name" string)
    (get "last_name" string)
    (get "position" string)
    (get "position_location" string)
