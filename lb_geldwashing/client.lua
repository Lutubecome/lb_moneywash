-- Array to store marker data
local markers = {

    {coords = vec3(774.27, -143.22, 62.44)},

}

local function startWash(amount)

    lib.notify({

        title = amount .. '$ Schwarzgeld wird gewashen...',
        type = 'inform',

    })
    
    --print(amount)

    local prozen = amount * 15 / 100

    local endmoney = amount - prozen
    
        if lib.progressCircle({
            label = 'Geld Waesche',
            duration = 30000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
                sprint = true,
            }
        }) then 
        
            TriggerServerEvent('lb_geldWash:moneyExchange', endmoney, amount)

            lib.notify({

                title = 'Waschen abgeschlossen!',
                type = 'success',

            })

            Citizen.Await(2000)

            lib.notify({

                title = 'Du hast ' .. endmoney .. '$ bekommen!',
                type = 'success',

            })

        else 
            
            lib.notify({

                title = 'Waschen abgebrochen!',
                type = 'error',

            })

            return
        
        end


end


local function openMenu()
    
    local blackmoney = lib.inputDialog("Geld Waesche", {{type = 'number', label = 'Schwarzgeld', description = 'Gib die Anzahl an Schwarzgeld ein.', icon = 'hashtag'},}, false)

    if not blackmoney then
        lib.notify({

            title = 'Es muss mindestens 1 Schwarzgeld angegeben werden!',
            type = 'inform',

        })
        return
    else if blackmoney[1] <= 0 then
        lib.notify({

            title = 'Es muss mindestens 1 Schwarzgeld angegeben werden!',
            type = 'inform',

        })
        return
        
        else

            local hasItem = lib.callback.await('lb_geldWash:hasBlackMoney')

            --print(hasItem)

            if hasItem >= blackmoney[1] then
                startWash(blackmoney[1])

            else
                lib.notify({

                    title = 'Nicht genug Schwarzgeld!',
                    type = 'error',
        
                })
            end
        end
    end
end

  --local pId = exports.qbx_core:GetPlayer(PlayerId())
  
  lib.registerContext({
    id = 'lb_geldWashMenu',
    title = 'Geld Waesche',
    options = {
      {
        title = 'Washen?',
        icon = 'money-bills',
        onSelect = function()
          openMenu()
        end,
      },
    }
  })

  -- Function to create a marker
  local function createMarker(markerData)
  
  local marker = lib.marker.new({
    coords = markerData.coords - vec3(0, 0, 1.6),
    type = 1,
    color = { r = 255, g = 0, b = 0, a = 100 }
  })
  
  -- Draw the marker and handle 'E' key press
  Citizen.CreateThread(function()
    while true do
      marker:draw()
  
      -- Check if player is near the marker and 'E' is pressed
      local playerCoords = GetEntityCoords(PlayerPedId())
      --print(playerCoords)
      local distance = #(playerCoords - markerData.coords)
      if distance < 1.0 and IsControlJustReleased(0, 51) then -- 38 is the key code for 'E'
      
        lib.showContext('lb_geldWashMenu')
      
      end
  
      Citizen.Wait(1)
    end
  end)
  end
  

    for _, markerData in ipairs(markers) do
        createMarker(markerData)
        end
  -- Loop through the markers array and create each marker

  