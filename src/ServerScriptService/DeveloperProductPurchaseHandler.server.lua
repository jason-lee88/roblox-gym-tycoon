local MarketplaceService = game:GetService("MarketplaceService")
local CashID = 21779310
local PurchaseHistory = game:GetService("DataStoreService"):GetDataStore("PurchaseHistory")
 
MarketplaceService.ProcessReceipt = function(receiptInfo) 
    local playerProductKey = receiptInfo.PlayerId .. ":" .. receiptInfo.PurchaseId
    if PurchaseHistory:GetAsync(playerProductKey) then
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end
    for i, player in ipairs(game.Players:GetPlayers()) do
        if player.userId == receiptInfo.PlayerId then
            if receiptInfo.ProductId == CashID then
                player.leaderstats.Cash.Value = player.leaderstats.Cash.Value + 20000
            end
        end	
    end
    PurchaseHistory:SetAsync(playerProductKey, true)	
    return Enum.ProductPurchaseDecision.PurchaseGranted		
end