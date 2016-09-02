module FormWidgets exposing (selectInputWidget, textInputWidget)

import Html exposing (Html, div, label, text)
import Html.Attributes exposing (class)

import Form exposing (Form, FieldState)
import Form.Input as Input


errorField field =
  case field.liveError of
    Just error ->
      div [ class "error" ] [ text (toString error) ]
    Nothing ->
      text ""


selectInputWidget : String -> List (String, String) -> FieldState b String -> Html Form.Msg
selectInputWidget labelText options field =
  div []
    [ label [] [ text labelText ]
    , Input.selectInput options field []
    , errorField field
    ]


textInputWidget : String -> FieldState b String -> Html Form.Msg
textInputWidget labelText field =
  div []
    [ label [] [ text labelText ]
    , Input.textInput field []
    , errorField field
    ]
