module Routing.Utils exposing (..)

import Hop exposing (..)
import Models exposing (..)
import Routing.Config exposing (..)


reverse : Route -> String
reverse route =
  case route of
    HomeRoute ->
      matcherToPath matcherHome []
    WealthStatementRoute ->
      matcherToPath matcherWealth []
    InterestsStatementRoute ->
      matcherToPath matcherInterests []
    NotFoundRoute ->
      ""
