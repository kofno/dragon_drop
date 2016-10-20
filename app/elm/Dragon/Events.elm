module Dragon.Events exposing (..)

import Dragon.Types exposing (FileTypes, FileList)
import Json.Decode as Json exposing (at, list, string, value)
import Html exposing (Attribute)
import Html.Events exposing (Options, onWithOptions, defaultOptions)


onDragOver : (FileTypes -> msg) -> Attribute msg
onDragOver f =
    onWithOptions "dragover" dragOptions (Json.map f dragDecoder)


onDragOut : msg -> Attribute msg
onDragOut msg =
    onWithOptions "dragleave" dragOptions (Json.succeed msg)


onDragEnter : msg -> Attribute msg
onDragEnter msg =
    onWithOptions "dragenter" dragOptions (Json.succeed msg)


onDrop : (FileList -> msg) -> Attribute msg
onDrop f =
    onWithOptions "drop" dragOptions (Json.map f dropDecoder)


dragOptions : Options
dragOptions =
    { defaultOptions | preventDefault = True, stopPropagation = True }


dragDecoder : Json.Decoder FileTypes
dragDecoder =
    at [ "dataTransfer", "types" ] (list string)


dropDecoder : Json.Decoder FileList
dropDecoder =
    at [ "dataTransfer", "files" ] value
