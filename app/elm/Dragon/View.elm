module Dragon.View exposing (..)

import Dragon.Types exposing (Model, Msg(..), DragHover(..), NativeFile)
import Dragon.Events exposing (onDragOver, onDragOut, onDrop, onDragEnter)
import Html exposing (Html, Attribute, text, div, p, ul, li, span)
import Html.Attributes exposing (style)


root : Model -> Html Msg
root model =
    div []
        [ div
            [ dropZoneStyles model.dragOver |> style
            , onDragEnter NoOp
            , onDragOver DragOver
            , onDragOut DragOut
            , onDrop Drop
            ]
            [ p [] [ text "Drop your import files here." ]
            , p [] [ text "Accepts .csv and .xls" ]
            ]
        , filesView model.files
        ]


filesView : Maybe (List NativeFile) -> Html Msg
filesView maybeFiles =
    case maybeFiles of
        Nothing ->
            span [] []

        Just files ->
            ul [] (List.map fileView files)


fileView : NativeFile -> Html Msg
fileView file =
    let
        size =
            if file.size > 1024 then
                (truncate (toFloat file.size / 1024) |> toString) ++ "K"
            else
                (toString file.size) ++ "B"
    in
        li []
            [ file.name ++ " ( " ++ size ++ " ) " ++ file.type_ |> text
            ]


dropZoneStyles : DragHover -> List ( String, String )
dropZoneStyles dragOver =
    case dragOver of
        NoDrag ->
            [ ( "border", "dashed black 2px" )
            , ( "border-radius", "2px" )
            , ( "font-size", "18px" )
            , ( "padding", "10px 20px" )
            ]

        FileDrag ->
            [ ( "border", "solid green 2px" )
            , ( "border-radius", "2px" )
            , ( "font-size", "18px" )
            , ( "padding", "10px 20px" )
            ]

        NoFiles ->
            [ ( "border", "solid red 2px" )
            , ( "border-radius", "2px" )
            , ( "font-size", "18px" )
            , ( "padding", "10px 20px" )
            ]
