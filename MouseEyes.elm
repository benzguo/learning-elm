import Mouse
import Window

main = lift2 scene Mouse.position Window.dimensions

toPolar (x, y) = (sqrt (x^2 + y^2),
                  atan2 y x)
toCart (r, t) = (r * (cos t),
                 r * (sin t))

eye (x, y) (dx, dy) = 
  let width = 50
      polar = toPolar (x - dx, y - dy)
      radius = fst polar
      theta = snd polar
  in toForm (collage width width 
              [ circle (width * 0.4) |> outlined (solid black)
              , circle (width * 0.2) |> filled black
                                     |> move (toCart (min radius 10,
                                                      theta))])
  

scene (x,y) (w,h) =
  let (dx,dy) = (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
  in  collage w h
       [ eye (dx, dy) (0, 0),
         eye (dx, dy) (50, 0) |> move (50, 0)
       ]