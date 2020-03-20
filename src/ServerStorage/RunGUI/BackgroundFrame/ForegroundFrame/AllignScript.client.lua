wait(5)

fg = script.Parent
bg = script.Parent.Parent
bgs = bg.AbsoluteSize

fg.Size = UDim2.new(0, bgs.x - 6, 0, bgs.y - 6)
fg.Position = UDim2.new(0, 3, 0, 3)

script.Parent.Parent.Visible = true