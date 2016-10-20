module Dragon.State exposing (..)

import Dragon.Types exposing (Model, Msg(..), DragHover(..))
import Dragon.Ports exposing (listFiles, files)


init : ( Model, Cmd Msg )
init =
    ( initialState, Cmd.none )


initialState : Model
initialState =
    { files = Nothing
    , dragOver = NoDrag
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        DragOver ft ->
            let
                isFileDrag =
                    List.member "Files" ft

                dragHover =
                    if isFileDrag then
                        FileDrag
                    else
                        NoFiles
            in
                { model | dragOver = dragHover } ! []

        DragOut ->
            { model | dragOver = NoDrag } ! []

        Drop fl ->
            { model | dragOver = NoDrag } ! [ listFiles fl ]

        Files files ->
            { model | files = Just files } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ files Files ]
