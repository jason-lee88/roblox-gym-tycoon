while true do
	repeat wait() until script.Parent.Parent.Parent.Owner.Value
		while script.Parent.Parent.Parent.Owner.Value do
		wait(1)
		if script.Parent.Trainer.Head.Transparency < 1 then
			script.Parent.Parent.Parent.Owner.Value.leaderstats.Cash.Value = script.Parent.Parent.Parent.Owner.Value.leaderstats.Cash.Value + script.Parent.Parent.Parent.TrainerIncomeAmount.Value
		end
	end
end