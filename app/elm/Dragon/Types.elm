module Dragon.Types exposing (..)

import Json.Decode


type alias Model =
    { files : Maybe (List NativeFile)
    , dragOver : DragHover
    }


type Msg
    = NoOp
    | DragOver FileTypes
    | DragOut
    | Drop FileList
    | Files (List NativeFile)


type DragHover
    = NoDrag
    | NoFiles
    | FileDrag


type alias FileTypes =
    List String


type alias FileList =
    Json.Decode.Value


type alias FileRef =
    Json.Decode.Value


type alias NativeFile =
    { type_ : String
    , name : String
    , size : Int
    , blob : FileRef
    }


type ImportableFile
    = TxtFile NativeFile
    | CsvFile NativeFile
    | XlsFile NativeFile
    | InvalidFile String NativeFile
