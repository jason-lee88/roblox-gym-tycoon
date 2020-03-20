script.Parent.Head.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player ~= nil then
		if player:WaitForChild("OwnsTycoon").Value == false then
			if script.Parent.Parent.Parent.Owner.Value == nil then
				if hit.Parent:FindFirstChild("Humanoid") then
					if hit.Parent.Humanoid.Health > 0 then
						player.OwnsTycoon.Value = true
						script.Parent.Parent.Parent.Owner.Value = player
						script.Parent.Name = player.Name.."'s Gym"
						script.Parent.Head.CanCollide = false
						script.Parent.Head.Transparency = .99
						for i,v in pairs(script.Parent.Head:GetChildren()) do
							if v:IsA("Decal") then
								v.Transparency = 1
							end
						end
						player.TeamColor = BrickColor.new(script.Parent.Parent.Parent.Name)
					end
				end
			end
		end
	end
end)