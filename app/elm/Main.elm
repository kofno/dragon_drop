module Main exposing (main)

import Html.App as App
import Dragon.State exposing (init, subscriptions, update)
import Dragon.View exposing (root)


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = root
        }
