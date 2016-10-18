module Updates exposing (Msg(..)
                       , FormName(..)
                       , IndexedFormName(..)
                       , update)

import Dict exposing (Dict)
import List

import Form exposing (Form)
import Hop exposing (makeUrl)
import Http
import Navigation

import Ajax
import Forms exposing (..)
import Models exposing (..)
import Routing.Config
import Routing.Utils


type FormName
  = StatementDateForm
  | PublicServantForm


type IndexedFormName
  = LandForm
  | BuildingForm


type alias FormId = Int


type Msg
  = NoOp
  | FormMsg FormName Form.Msg
  | IndexedFormMsg IndexedFormName FormId Form.Msg
  | AddForm IndexedFormName
  | PreviousSection
  | NextSection
  | ShowHome
  | ShowWealthStatement
  | ShowInterestsStatement
  | SendFormData
  | SaveFail Http.Error
  | SaveSuccess String


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
        LandForm ->
           let
             newForm = Form.initial [] validateLand
             newFormKey = List.length <| Dict.values model.landForms
             landForms = Dict.insert newFormKey newForm model.landForms
           in
             ({ model | landForms = landForms }, Cmd.none )
        BuildingForm ->
          (model, Cmd.none)

    -- Http
    SendFormData ->
      (model, Ajax.saveForms model)
    SaveFail error ->
      (model, Cmd.none)
    SaveSuccess response ->
      (model, Cmd.none)

    -- Sections
    PreviousSection ->
      ({ model | currentSection = model.currentSection - 1 }, Cmd.none)
    NextSection ->
      ({ model | currentSection = model.currentSection + 1 }, Cmd.none)

    -- Navigation
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


updateForm : FormName -> Form.Msg -> Model -> (Model, Cmd Msg)
updateForm formName formMsg model =
  case formName of
    StatementDateForm ->
      ({ model | statementDateForm = Form.update formMsg model.statementDateForm }, Cmd.none)
    PublicServantForm ->
      ({ model | publicServantForm = Form.update formMsg model.publicServantForm }, Cmd.none)


updateIndexedForm : IndexedFormName -> FormId -> Form.Msg -> Model -> (Model, Cmd Msg)
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
      LandForm ->
        let
          landForms = Dict.update formId update' model.landForms
        in
          ({ model | landForms = landForms }, Cmd.none)
      BuildingForm ->
        (model, Cmd.none)
