wall = script.Parent.Wall
left = script.Parent.Wall
right = script.Parent.Wall
centralPosition = script.Parent.Wall

while true do
  wait(3)
  wall.Position = left.Position
  wait(3)
  wall.Position = central.Position
  wait(3)
  wall.Position = right.Positon
  wait(3)
  wall.Position = centralPosition
end
