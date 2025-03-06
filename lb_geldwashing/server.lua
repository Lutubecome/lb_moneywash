RegisterNetEvent('lb_geldWash:moneyExchange', function (amountgive, amountget)
    
    exports.ox_inventory:RemoveItem(source, 'black_money', amountget)
    exports.ox_inventory:AddItem(source, 'cash', amountgive)

end)


lib.callback.register('lb_geldWash:hasBlackMoney', function()
   
    local hasItem = exports.ox_inventory:GetItem(source, 'black_money', nil, true)

    return hasItem

end)