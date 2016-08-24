module Views exposing (..)

import Array exposing (Array)
import Debug exposing (log)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Form exposing (Form, FieldState)
import Form.Input as Input

import Models exposing (..)
import Updates exposing (..)


sections : Array (Model -> Html Form.Msg)
sections = Array.fromList
 [ statementFormView
 , publicServantFormView
 ]


view : Model -> Html Msg
view model =
  sectionView model


sectionView : Model -> Html Msg
sectionView model =
  let
    result = Array.get model.currentSection sections
  in
    case result of
      Just currentView -> div [] [
                            Html.map FormMsg (currentView model)
                          , previousButtonView model
                          , nextButtonView model
                          , Html.map FormMsg (submitButtonView model)
                          ]
      Nothing -> text "Page could not be found"


previousButtonView : Model -> Html Msg
previousButtonView model =
  if model.currentSection > 0 then
    button [ onClick PreviousSection ] [ text "Înapoi" ]
  else
    text ""


nextButtonView : Model -> Html Msg
nextButtonView model =
  if model.currentSection < (Array.length sections - 1) then
    button [ onClick NextSection ] [ text "Înainte"]
  else
    text ""


submitButtonView : Model -> Html Form.Msg
submitButtonView model =
  if model.currentSection == (Array.length sections - 1) then
    button [ onClick Form.Submit ] [ text "Trimite" ]
  else
    text ""


statementFormView : Model -> Html Form.Msg
statementFormView model =
  let
   date = Form.getFieldAsString "date" model.statementDateForm
  in
    div [] [
      label [] [ text "Data declarației: " ]
    , Input.textInput date []
    , errorField date
    ]


publicServantFormView : Model -> Html Form.Msg
publicServantFormView model =
  let
    first_name = Form.getFieldAsString "first_name" model.publicServantForm
    last_name = Form.getFieldAsString "last_name" model.publicServantForm
    position = Form.getFieldAsString "position" model.publicServantForm
    position_location = Form.getFieldAsString "position_location" model.publicServantForm
  in
    div [] [
      label [] [ text "Prenume: " ]
    , Input.textInput first_name []
    , errorField first_name

    , label [] [ text "Nume: "]
    , Input.textInput last_name []
    , errorField last_name

    , label [] [ text "Funcție: "]
    , Input.textInput position []
    , errorField position

    , label [] [ text "Locul funcției: "]
    , Input.textInput position_location []
    , errorField position
    ]


-- No annotation, to avoid importing VirtualDom
errorField field =
  case field.liveError of
    Just error ->
      div [ class "error" ] [ text (toString error) ]
    Nothing ->
      text ""
