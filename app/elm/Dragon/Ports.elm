port module Dragon.Ports exposing (..)

import Dragon.Types exposing (FileList, NativeFile)


port listFiles : FileList -> Cmd msg


port files : (List NativeFile -> msg) -> Sub msg
