local ods = game:GetService("DataStoreService"):GetOrderedDataStore("Strength")
function updateBoard(board, data)
	for k,v in pairs(data) do
		local pos = k
		local name = v.key
		local score = v.value
		local dispname = board:findFirstChild("Name"..pos)
		local dispval = board:findFirstChild("Score"..pos)
		dispname.Text = tostring(name)
		dispval.Text = tostring(score)
	end	
end

while true do
	local pages = ods:GetSortedAsync(false, 10)
	local data = pages:GetCurrentPage()
	updateBoard(game.Workspace.HighScore.TopBlock.SurfaceGui, data)
	wait(60)
end
