module Ajax exposing (saveForms)

import Json.Decode as Decode
import Json.Encode as Encode
import Http
import Task

import Date.Format
import Form exposing (Form, getOutput)

import Models exposing (..)
import Updates exposing (Msg(SaveFail, SaveSuccess))


saveUrl : String
saveUrl =
  "http://localhost:8000/api/statements/wealth/"


saveForms : Model -> Cmd Msg
saveForms model =
  let
    body = Http.string <| Encode.encode 0 (encodeForms model)
    request =
      Http.send Http.defaultSettings
        { verb = "POST"
        , headers = [ ("X-CSRFToken", model.csrfToken)
                    , ("Content-Type", "application/json")
                    ]
        , url = saveUrl
        , body = body
        }
  in
    Task.perform SaveFail SaveSuccess <| Http.fromJson Decode.string request


encodeForms : Model -> Encode.Value
encodeForms model =
  let
    date = convertStatementDate model.statementDateForm
    public_servant = convertPublicServant model.publicServantForm
    lands = convertLands model.landForms
  in
    date
    |> List.append public_servant
    |> List.append lands
    |> Encode.object


convertStatementDate : Form () StatementDate -> List (String, Encode.Value)
convertStatementDate statementDateForm =
  let
    output = getOutput statementDateForm
  in
    case output of
      Just date ->
        [ ("date", Encode.string <| Date.Format.format "%d-%m-%Y" date.date) ]
      Nothing ->
        []


convertPublicServant : Form () PublicServant -> List (String, Encode.Value)
convertPublicServant publicServantForm =
  let
    output = getOutput publicServantForm
    publicServant =
      case output of
        Just servant ->
          [ ("first_name", Encode.string servant.first_name)
          , ("last_name", Encode.string servant.last_name)
          , ("position", Encode.string servant.position)
          , ("position_location", Encode.string servant.position_location)
          ]
        Nothing ->
          []
  in
    [("public_servant", Encode.object publicServant)]


convertLands : Dict Int (Form () Land) -> List (String, Encode.Value)
convertLands landForms =
  let
    lands = List.filterMap convertLand (Dict.values landForms)
  in
    [("lands", Encode.list lands)]


convertLand : Form () Land -> Maybe Encode.Value
convertLand landForm =
  let
    output = getOutput landForm
    encodeFields land =
      [ ("location", Encode.string land.location)
      , ("category", Encode.int land.category)
      , ("year_acquired", Encode.string land.year_acquired)
      , ("area", Encode.float land.area)
      , ("share", Encode.int land.share)
      , ("method_acquired", Encode.string land.method_acquired)
      , ("owner", Encode.string land.owner)
      ]
  in
    output `Maybe.andThen` (\v -> Just <| Encode.object <| encodeFields v)
