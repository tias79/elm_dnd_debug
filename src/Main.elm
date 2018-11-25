module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (..)
import Html5.DragDrop as DragDrop



---- MODEL ----


type alias Model =
    { dragDrop : DragDrop.Model Int Int }


init : ( Model, Cmd Msg )
init =
    ( {dragDrop = DragDrop.init}, Cmd.none )



---- UPDATE ----


type Msg
    = Drop (DragDrop.Msg Int Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of
    Drop msg_ ->
            let
                ( model_, result ) =
                    DragDrop.update msg_ model.dragDrop
            in
                case (Debug.log "result" result) of
                    Nothing ->
                        (model, Cmd.none )

                    Just ( src, target, _ ) ->
                        (model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div ([class "box"] ++ (DragDrop.draggable Drop 1) ++ (DragDrop.droppable Drop 1)) [ text "#1" ]
        , div ([class "box"] ++ (DragDrop.draggable Drop 2) ++ (DragDrop.droppable Drop 2)) [ text "#2" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
