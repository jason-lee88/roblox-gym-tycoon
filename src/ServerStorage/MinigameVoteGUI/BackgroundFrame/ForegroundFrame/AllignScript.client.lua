wait(5)

fg = script.Parent
bg = script.Parent.Parent
bgs = bg.AbsoluteSize

fg.Size = UDim2.new(0, bgs.x - 12, 0, bgs.y - 12)
fg.Position = UDim2.new(0, 6, 0, 6)

script.Parent.Parent.Visible = true