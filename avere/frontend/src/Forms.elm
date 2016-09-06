module Forms exposing (validateStatementDate
                     , validatePublicServant
                     , validateLand)

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


validateLand : Validation () Land
validateLand =
  form7 Land
    (get "location" (string `andThen` maxLength 255))
    (get "category" int)
    (get "year_acquired" int)
    (get "area" float)
    (get "share" int)
    (get "method_acquired" (string `andThen` maxLength 255))
    (get "owner" (string `andThen` maxLength 255))
