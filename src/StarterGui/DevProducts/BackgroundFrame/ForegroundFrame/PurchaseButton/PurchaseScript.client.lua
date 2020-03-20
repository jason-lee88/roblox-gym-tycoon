local productid = 21779310

script.Parent.MouseButton1Click:connect(function()
	game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer, productid)
end)