module Page.CategoryList exposing (init, initAnim, Msg(..), Model, view, getCategoryWithId)

import Data.Category exposing (..)
import Request.Category exposing (..)
import Request.Helpers exposing (ApiKey, Context, NodeEnv)
import Views.Container exposing (rowView, popInInitialAnim)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Http
import Task
import Animation


-- MODEL


type alias Model =
    List Category


init : NodeEnv -> ApiKey -> Context -> Task.Task Http.Error Categories
init env apiKey context =
    Http.toTask <| requestCategories env apiKey context


initAnim : Animation.State
initAnim =
    Animation.style popInInitialAnim



-- UPDATE


type Msg
    = LoadCategory CategoryId



-- VIEW


view : Model -> Html Msg
view model =
    rowView []
        (List.map
            (\category ->
                div
                    [ onClick <| LoadCategory category.id
                    , style [ ( "cursor", "pointer" ) ]
                    ]
                    [ text category.name ]
            )
            model
        )


getCategoryWithId : CategoryId -> Model -> Maybe Category
getCategoryWithId categoryId categoryList =
    List.head <|
        List.filter
            (\category -> category.id == categoryId)
            categoryList
