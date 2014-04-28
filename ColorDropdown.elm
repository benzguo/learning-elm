import Dict
import Touch
import Window
import Graphics.Input (Input, input, dropDown)

main = scene <~ Window.dimensions
             ~ (Dict.values <~ foldp addN Dict.empty Touch.touches)
             ~ colorInput.signal
            

addN : [Touch.Touch] -> Dict.Dict Int [(Int,Int)] -> Dict.Dict Int [(Int,Int)]
addN ts dict = foldl add1 dict ts

add1 : Touch.Touch -> Dict.Dict Int [(Int,Int)] -> Dict.Dict Int [(Int,Int)]
add1 t d = let vs = Dict.findWithDefault [] t.id d
           in  Dict.insert t.id ((t.x,t.y) :: vs) d

scene : (Int,Int) -> [[(Int,Int)]] -> Color -> Element
scene (w,h) paths color =
    let float (a,b) = (toFloat a, toFloat -b)
        line c = (traced (thickLineStyle c) . path . map float)
        pathForms = group (map (line color) paths)
        picture = collage w h [ move (float (-w `div` 2, -h `div` 2)) pathForms ]
    in  layers [ picture, dropDown colorInput.handle options ]

thickLineStyle : Color -> LineStyle
thickLineStyle c = { defaultLine | color <- c, width <- 8 }


-- Dropdown

colorInput : Input (Color)
colorInput = input black

options : [(String, Color)]
options = [ ("black"   , black)
          , ("red"     , red)
          , ("blue"    , blue)]