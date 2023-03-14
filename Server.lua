
--------------------------------------------------------
-----------------------Game Light-----------------------
-------- Discord https://discord.gg/HFwHnGguun ---------
--------------------------------------------------------

addEventHandler("onResourceStart", resourceRoot,
function()
	db = dbConnect("sqlite", "database.db")
	dbExec(db, "CREATE TABLE IF NOT EXISTS Garagem ( ID, X, Y, Z)")
end)

addEvent("updateINTDIM2", true)
addEventHandler("updateINTDIM2", getRootElement(), function (vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do
			if getElementData(value, "dbid") == tonumber(vehicleId) then
				if getElementData(value, "owner") == getElementData(source, "dbid") then
				local data = dbPoll(dbQuery(db, "SELECT * FROM Garagem WHERE ID = ?", vehicleId), -1)
				if type(data) == "table" and #data ~= 0 then
				local x = data[1]["X"]
				local y = data[1]["Y"]
				local z = data[1]["Z"]
				local xp,yp,zp = getElementPosition ( source ) 
					setElementInterior(value,0)
					setElementDimension(value,0)
					setElementPosition(value, xp +0.8, yp, zp)
					warpPedIntoVehicle ( source, value, 0 ) 
					dbExec(db, "DELETE FROM Garagem WHERE ID = ? ", vehicleId)
				end
			end
		end
	end
end
)

addEvent("guardar", true)
addEventHandler("guardar", getRootElement(), function (vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do
			if getElementData(value, "dbid") == tonumber(vehicleId) then
				if getElementData(value, "owner") == getElementData(source, "dbid") then
				ID = getElementData(value,"dbid")
			   local xc,yc,zc = getElementPosition ( value )
		       local x2,y2,z2 = getElementPosition ( source )
			   local dist = getDistanceBetweenPoints3D ( xc, yc, zc, x2, y2, z2 )
			   if getElementData (source, "DelayGuarda", true) then  
			   return end 
				local x, y, z = getElementPosition(value)
				local _, _, rz = getElementRotation(value)
				dbExec(db, "INSERT INTO Garagem VALUES(?, ?, ?, ?)", vehicleId, x, y, z)
				
				removePedFromVehicle ( source , value)
		
				local gerarposicao = math.random(50,100)
				setElementPosition(value,1805.39368, -2448.51196, 13.44729)
				setElementInterior(value,gerarposicao)
				setElementDimension(value,gerarposicao)
					
				exports.anticheat:changeProtectedElementDataEx(value, "requires.vehpos")
				local x, y, z = getElementPosition(value)
				local rx, ry, rz = getVehicleRotation(value)
				local destroyTimers = { }
				local interior = getElementInterior(source)
				local dimension = getElementDimension(source)

				setVehicleRespawnPosition(value, x, y, z, rx, ry, rz)
				exports.anticheat:changeProtectedElementDataEx(value, "respawnposition", {x, y, z, rx, ry, rz}, false)
				exports.anticheat:changeProtectedElementDataEx(value, "interior", interior)
				exports.anticheat:changeProtectedElementDataEx(value, "dimension", dimension)
				outputChatBox("#9ACD32[GameLight] #ffffffYour vehicle is parked.",source,0,0,0,true)
				exports.logs:dbLog(thePlayer, 4, {  value }, "PARK")
				for key, value in ipairs(destroyTimers) do
					if (tonumber(destroyTimers[key][2]) == getElementData(source, "dbid")) then
						local timer = destroyTimers[key][1]

						if (isTimer(timer)) then
							killTimer(timer)
							table.remove(destroyTimers, key)
						end
					end
				end
			    setElementData (source, "DelayGuarda",true)
				setTimer (setElementData, 3000, 1, source, "DelayGuarda", false)
				  else
				outputChatBox("#9ACD32[GameLight] #ffffffYou have no means.",source,0,0,0,true)
			end
		end
	end
end
)

addEvent("updateINTDIM22", true)
addEventHandler("updateINTDIM22", getRootElement(), function (vehicleId)
		for index, value in ipairs (getElementsByType("vehicle")) do
			if getElementData(value, "dbid") == tonumber(vehicleId) then
				if getElementData(value, "owner") == getElementData(source, "dbid") then
					setElementInterior(value,0)
					setElementDimension(value,0)
			end
		end
	end
end
)

--------------------------------------------------------
-----------------------Game Light-----------------------
-------- Discord https://discord.gg/HFwHnGguun ---------
--------------------------------------------------------
