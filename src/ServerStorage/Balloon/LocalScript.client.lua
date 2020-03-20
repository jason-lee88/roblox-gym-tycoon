function Leap()

	script.Parent.Parent.Humanoid.Jump = false

end

game.Players.LocalPlayer:WaitForChild("Character"):WaitForChild("Humanoid").Jumping:connect(Leap)