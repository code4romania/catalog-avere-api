module Updates exposing (Msg(FormMsg
                           , IndexedFormMsg
                           , PreviousSection
                           , NextSection
                           , ShowHome
                           , ShowWealthStatement
                           , ShowInterestsStatement)
                       , update)

import Form exposing (Form)
import Hop exposing (makeUrl)
import Navigation

import Models exposing (..)
import Routing.Config
import Routing.Utils


type alias FormName = String
type alias FormId = Int


type Msg
  = NoOp
  | FormMsg FormName Form.Msg
  | IndexedFormMsg FormName FormId Form.Msg
  | PreviousSection
  | NextSection
  | ShowHome
  | ShowWealthStatement
  | ShowInterestsStatement


navigationCmd : String -> Cmd a
navigationCmd path =
  Navigation.newUrl (makeUrl Routing.Config.config path)


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
