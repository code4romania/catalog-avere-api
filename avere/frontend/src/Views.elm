module Views exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)

import Html exposing (..)
import Html.Attributes exposing (class, disabled, href, id)
import Html.Events exposing (onClick)

import Form exposing (Form, FieldState, getErrors)

import Models exposing (..)
import Routing.Config exposing (..)
import Updates exposing (..)

import SectionViews exposing (sections)


view : Model -> Html Msg
view model =
  div []
    [ menu model
    , pageView model
    ]


menu : Model -> Html Msg
menu model =
  div [ class "p2 white bg-black" ]
    [ div []
        [ menuLink ShowHome "btnHome" "Home"
        ]
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


menuLink : Msg -> String -> String -> Html Msg
menuLink message viewId label =
  a [ id viewId
    , href "javascript://"
    , onClick message
    , class "red px2"
    ]
    [ text label
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


sectionView : Model -> Html Msg
sectionView model =
  let
    result = Array.get model.currentSection sections
  in
    case result of
      Just currentView -> div []
                            [ currentView model
                            , previousButtonView model
                            , nextButtonView model
                            ]
      Nothing -> text "Page could not be found"


-- BUTTONS
previousButtonView : Model -> Html Msg
previousButtonView model =
  if model.currentSection > 0 then
    button [ disabled <| formsHaveErrors model, onClick PreviousSection ]
      [ text "Înapoi" ]
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


formsHaveErrors : Model -> Bool
formsHaveErrors model =
  let
    multiFormErrors forms =
      Dict.map (\k form -> getErrors form) forms
      |> Dict.values
      |> List.concat

    statementDateErrors = getErrors model.statementDateForm
    publicServantErrors = getErrors model.publicServantForm
    landErrors = multiFormErrors model.landForms
  in
    not (List.length statementDateErrors == 0 &&
         List.length publicServantErrors == 0 &&
         List.length landErrors == 0)

