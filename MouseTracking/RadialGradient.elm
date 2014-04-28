import Mouse
import Window

main = lift2 scene Mouse.position Window.dimensions

scene (x,y) (w,h) =
  let (dx,dy) = (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
  in  collage w h
       [(gradient (grad dx dy) (circle 100))]

grad : Float -> Float -> Gradient
grad x y = radial ((clamp -50 50 x),(clamp -50 50 y)) 20 (0,0) 90
          [ (  0, rgb  244 242 1)
          , (0.8, rgb  228 199 0)
          , (  1, rgba 228 199 0 0)
          ]


