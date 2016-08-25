module Updates exposing (Msg(FormMsg
                           , PreviousSection
                           , NextSection)
                       , update)

import Form exposing (Form)

import Models exposing (..)


type Msg
  = NoOp
  | FormMsg Form.Msg
  | PreviousSection
  | NextSection


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({publicServantForm} as model) =
  case msg of
    NoOp ->
      (model, Cmd.none)
    FormMsg formMsg ->
      ({ model | publicServantForm = Form.update formMsg publicServantForm }, Cmd.none)
    PreviousSection ->
      ({ model | currentSection = model.currentSection - 1 }, Cmd.none)
    NextSection ->
      ({ model | currentSection = model.currentSection + 1 }, Cmd.none)
