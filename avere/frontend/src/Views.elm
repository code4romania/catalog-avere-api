module Views exposing (..)

import Array exposing (Array)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (class, href, id)
import Html.Events exposing (onClick)

import Form exposing (Form, FieldState)
import Form.Input as Input

import Models exposing (..)
import Routing.Config exposing (..)
import Updates exposing (..)


menu : Model -> Html Msg
menu model =
  div [ class "p2 white bg-black" ]
    [ div []
        [ menuLink ShowHome "btnHome" "Home"
        ]
    ]


menuLink : Msg -> String -> String -> Html Msg
menuLink message viewId label =
  a [ id viewId
    , href "javascript://"
    , onClick message
    , class "red px2"
    ]
    [ text label
    ]


pageView : Model -> Html Msg
pageView model =
  case model.route of
    HomeRoute ->
      homeView model
    WealthStatementRoute ->
      wealthStatementView model
    InterestsStatementRoute ->
      interestsStatementView model
    NotFoundRoute ->
      notFoundView model


homeView : Model -> Html Msg
homeView model =
  div [ class "p2" ]
    [ h1 [ id "title", class "m0" ]
        [ text "Declarații" ]
    , p []
        [ menuLink ShowWealthStatement "wealth" "Avere" ]
    , p []
        [ menuLink ShowInterestsStatement "interests" "Interese" ]
    ]


wealthStatementView : Model -> Html Msg
wealthStatementView model =
  div [ class "p2" ]
    [ h1 [ id "title", class "m0" ]
        [ text "Avere"
        ]
    , sectionView model
    ]


interestsStatementView : Model -> Html Msg
interestsStatementView model =
  div [ class "p2" ]
    [ h1 [ id "title", class "m0" ]
        [ text "Interese"
        ]
    ]


notFoundView : Model -> Html msg
notFoundView model =
    div []
      [ text "Not Found"
      ]


sections : Array (Model -> Html Form.Msg)
sections = Array.fromList
 [ statementFormView
 , publicServantFormView
 ]


view : Model -> Html Msg
view model =
  div []
    [ menu model
    , pageView model
    ]


sectionView : Model -> Html Msg
sectionView model =
  let
    result = Array.get model.currentSection sections
  in
    case result of
      Just currentView -> div []
                            [ Html.map FormMsg (currentView model)
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
    button [ onClick NextSection ] [ text "Înainte" ]
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
    div []
      [ textInputWidget "Data declarației: " date
      ]


publicServantFormView : Model -> Html Form.Msg
publicServantFormView model =
  let
    first_name = Form.getFieldAsString "first_name" model.publicServantForm
    last_name = Form.getFieldAsString "last_name" model.publicServantForm
    position = Form.getFieldAsString "position" model.publicServantForm
    position_location = Form.getFieldAsString "position_location" model.publicServantForm
  in
    div []
      [ textInputWidget "Prenume: " first_name
      , textInputWidget "Nume: " last_name
      , textInputWidget "Funcție: " position
      , textInputWidget "Locul funcției: " position_location
      ]


-- UTILS
textInputWidget : String -> FieldState b String -> Html Form.Msg
textInputWidget labelText field =
  div []
    [ label [] [ text labelText ]
    , Input.textInput field []
    , errorField field
    ]


-- No annotation, to avoid importing VirtualDom
errorField field =
  case field.liveError of
    Just error ->
      div [ class "error" ] [ text (toString error) ]
    Nothing ->
      text ""
