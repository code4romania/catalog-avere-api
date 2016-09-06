module Updates exposing (Msg(FormMsg
                           , IndexedFormMsg
                           , AddForm
                           , PreviousSection
                           , NextSection
                           , ShowHome
                           , ShowWealthStatement
                           , ShowInterestsStatement)
                       , update)

import Dict exposing (Dict)
import List

import Form exposing (Form)
import Hop exposing (makeUrl)
import Navigation

import Forms exposing (..)
import Models exposing (..)
import Routing.Config
import Routing.Utils


type alias FormName = String
type alias FormId = Int


type Msg
  = NoOp
  | FormMsg FormName Form.Msg
  | IndexedFormMsg FormName FormId Form.Msg
  | AddForm FormName
  | PreviousSection
  | NextSection
  | ShowHome
  | ShowWealthStatement
  | ShowInterestsStatement


navigationCmd : String -> Cmd a
navigationCmd path =
  Navigation.newUrl (makeUrl Routing.Config.config path)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)
    FormMsg formName formMsg ->
      updateForm formName formMsg model
    IndexedFormMsg formName formId formMsg ->
      updateIndexedForm formName formId formMsg model
    AddForm formName ->
      case formName of
        "landForm" ->
           let
             newForm = Form.initial [] validateLand
             newFormKey = List.length <| Dict.values model.landForms
             landForms = Dict.insert newFormKey newForm model.landForms
           in
             ({ model | landForms = landForms }, Cmd.none )
        _ ->
          (model, Cmd.none)

    PreviousSection ->
      ({ model | currentSection = model.currentSection - 1 }, Cmd.none)
    NextSection ->
      ({ model | currentSection = model.currentSection + 1 }, Cmd.none)
    ShowHome ->
      let
        path = Routing.Utils.reverse Routing.Config.HomeRoute
      in
        ( model, navigationCmd path)
    ShowWealthStatement ->
      let
        path = Routing.Utils.reverse Routing.Config.WealthStatementRoute
      in
        ( model, navigationCmd path)
    ShowInterestsStatement ->
      let
        path = Routing.Utils.reverse Routing.Config.InterestsStatementRoute
      in
        ( model, navigationCmd path)


updateForm : String -> Form.Msg -> Model -> (Model, Cmd Msg)
updateForm formName formMsg model =
  case formName of
    "statementDateForm" ->
      ({ model | statementDateForm = Form.update formMsg model.statementDateForm }, Cmd.none)
    "publicServantForm" ->
      ({ model | publicServantForm = Form.update formMsg model.publicServantForm }, Cmd.none)
    _ ->
      (model, Cmd.none)


updateIndexedForm : String -> Int -> Form.Msg -> Model -> (Model, Cmd Msg)
updateIndexedForm formName formId formMsg model =
  let
    update' v =
      case v of
        Just form ->
          Just (Form.update formMsg form)
        Nothing ->
          v
  in
    case formName of
      "landForm" ->
        let
          landForms = Dict.update formId update' model.landForms
        in
          ({ model | landForms = landForms }, Cmd.none)
      _  ->
        (model, Cmd.none)
