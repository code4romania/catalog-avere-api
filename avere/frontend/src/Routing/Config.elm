module Routing.Config exposing (Route(..)
                              , config
                              , matcherHome
                              , matcherWealth
                              , matcherInterests
                              )

import Hop.Matchers exposing (match1)
import Hop.Types exposing (Config, PathMatcher)


type Route
  = HomeRoute
  | NotFoundRoute
  | WealthStatementRoute
  | InterestsStatementRoute


matcherHome : PathMatcher Route
matcherHome =
  match1 HomeRoute ""


matcherWealth : PathMatcher Route
matcherWealth =
  match1 WealthStatementRoute "/avere"


matcherInterests : PathMatcher Route
matcherInterests =
  match1 InterestsStatementRoute "/interese"


matchers : List (PathMatcher Route)
matchers =
  [ matcherHome
  , matcherWealth
  , matcherInterests
  ]


config : Config Route
config =
  { basePath = ""
  , hash = True
  , matchers = matchers
  , notFound = NotFoundRoute
  }