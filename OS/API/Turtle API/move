rednet.open("right")
comName = os.getComputerLabel()

--GLOBAL VARIABLES--

hostServer = 15
fuelSlot = 1
reqFuel = 80
seedSlot1 = 2
seedSlot2 = 3
north = 0
east = 1
south = 2
west = 3
safezone = 120
state = "idle"
homeX = 166
homeY = 60
homeZ = -2360
curSlot = 1

--REDNET FUNCTIONS--

function report(msg)
    rednet.open("right")
    clear()
    print(msg)
    state = msg
    dumpLoc()
end

function sendFile()
    reportData = fs.open("loc", "r")
    data = reportData.readAll()
    reportData.close()
    rednet.send(hostServer, data)
end

--FILING FUNCTIONS--

function getLoc()
    if fs.exists("loc") then
   	    data = fs.open("loc", "r")
      		x = tonumber(data.readLine())
      		y = tonumber(data.readLine())
      		z = tonumber(data.readLine())
      		h = tonumber(data.readLine())
      		data.close()
   	else
	       x = homeX
      		y = homeY
      		z = homeZ
      		h = 0
        dumpLoc()
    end
end

function dumpLoc()
    if fs.exists("loc") then
   	    fs.delete("loc")
    end
   	data = fs.open("loc", "w")
   	data.writeLine(tostring(x))
   	data.writeLine(tostring(y))
   	data.writeLine(tostring(z))
   	data.writeLine(tostring(h))
    data.writeLine(tostring(comName))
    data.writeLine(tostring(state))
   	data.close()
    sleep(0.2)
    sendFile()
end

--MOVEMENT FUNCTIONS--

function refuel()
    fuel = turtle.getFuelLevel()
    while fuel < reqFuel do
        if turtle.getItemCount(fuelSlot) == 0 then
            break
        else
            turtle.refuel(1)
            fuel = turtle.getFuelLevel()
        end
    end
end

function fd(dig)
    getLoc()
   	refuel()
    while true do
        if dig == "dig" or dig == "d" or dig == "Dig" or dig == "D" then
            turtle.dig()
        elseif dig == nil then
        end
        if turtle.forward() then
  		        if h == 0 then
	               z = z - 1
         			elseif h == 1 then
         			    x = x + 1
      		    elseif h == 2 then
	               z = z + 1
     			    elseif h == 3 then
     			        x = x - 1
     		    	end
            report("Moving.")
            break
      		else
	           report("Blocked")
      		end
    end
    dumpLoc()
end

function up(dig)
    getLoc()
   	refuel()
    while true do
        if dig == "dig" or dig == "d" or dig == "Dig" or dig == "D" then
            turtle.digUp()
        elseif dig == nil then
        end
        if turtle.up() then
            y = y + 1
            report("Moving.")
            break
      		else
  		        report("Blocked")
      		end
    end
    dumpLoc()
end

function dn(dig)
    getLoc()
   	refuel()
    while true do
        if dig == "dig" or dig == "d" or dig == "Dig" or dig == "D" then
            turtle.digDown()
        elseif dig == nil then
        end
        if turtle.down() then
            y = y - 1
            report("Moving.")
            break
      		else
            report("Blocked")
      		end
    end
    dumpLoc()
end

function rt()
    getLoc()
    report("Turning.")
    turtle.turnRight()
    --report("Updating data file.")
    h = (h + 1) % 4
   	dumpLoc()
end

function lt()
    getLoc()
    turtle.turnLeft()
    h = (h - 1) % 4
    while h < 0 do
        h = h + 4
    end
   	dumpLoc()
end

function spin()
    rt()
    rt()
end

--ADVANCED MOVEMENT FUNCTIONS--

function gofd(dist)
    if dist == nil then
   	    fd()
   	else
	       while dist > 0 do
      		    fd()
            dist = dist - 1
      		end
   	end
end

function face(b)
    getLoc()
    while true do
        if b == h then
            break
        else
            getLoc()
            rt()
            dumpLoc()
            --report("Turning. "..tostring(h))
        end
  		end
end

function findX(pos, dig)
    getLoc()
   	if x > pos then
	       face(west)
      		while x > pos do
            if dig == nil then
          		    fd()
                getLoc()
            else
                fd("dig")
                getLoc()
          		end
        end
   	elseif x < pos then
	       face(east)
        while x < pos do
            if dig == nil then
    		          fd()
                getLoc()
            else
                fd("dig")
                getLoc()
            end
      		end
   	else
   	end
end

function findZ(pos, dig)
    getLoc()
   	if z > pos then
	       face(north)
      		while z > pos do
            if dig == nil then
    		          fd()
                getLoc()
            else
                fd("dig")
                getLoc()
            end
      		end
   	elseif z < pos then
	       face(south)
        while z < pos do
            if dig == nil then
    		          fd()
                getLoc()
            else
                fd("dig")
                getLoc()
            end
      		end
   	else
   	end
end

function findY(height, dig)
    getLoc()
    if y > height then
        while y > height do
            if dig == nil then
    	           dn()
                getLoc()
            else
                dn("dig")
                getLoc()
            end
	       end
    elseif y < height then
   	    while y < height do
            if dig == nil then
    		          up()
                getLoc()
            else
                up("dig")
                getLoc()
            end
      		end
   	else
   	end
end

function moveTo(newx, newy, newz, heading, tunnel)
    if tunnel == nil then
        findY(safezone)
        findX(newx)
       	findZ(newz)
       	findY(newy)
    else
        findY(safezone, "dig")
        findX(newx, "dig")
        findZ(newz, "dig")
        findY(newy, "dig")
    end
    if heading == nil then
        face(north)
    else
        face(heading)
    end
    report("idle")
end

function goHome(dig)
    if dig == nil then
        findY(safezone)
        findZ(homeZ)
        findX(homeX)
        findY(homeY)
    else
        findY(safezone, "dig")
        findZ(homeZ, "dig")
        findX(homeX, "dig")
        findY(homeY, "dig")
    end
    face(north)
    report("Home.")
end

function setTempHome()
    data = fs.open("loc", "r")
    tempHomeX = tonumber(data.readLine())
    tempHomeY = tonumber(data.readLine())
    tempHomeZ = tonumber(data.readLine())
    tempHomeH = tonumber(data.readLine())
    data.close()
end

function returnTempHome()
    findX(tempHomeX)
    findZ(tempHomeZ)
    findY(tempHomeY)
    face(tempHomeH)
end

function setTemp()
    data = fs.open("loc", "r")
    tempX = tonumber(data.readLine())
    tempY = tonumber(data.readLine())
    tempZ = tonumber(data.readLine())
    tempH = tonumber(data.readLine())
    data.close()
end

function returnTemp()
    findX(tempX)
    findZ(tempZ)
    findY(tempY)
    face(tempH)
end

function launch()
    face(north)
    fd()
   	findY(safezone, "d")
end

function disable()
    spin()
    fd()
   	face(west)
   	fd()
    while true do
        if turtle.detect() then
            face(south)
            fd()
            face(west)
        else
            fd()
            face(east)
            break
        end
    end
end

function enable()
    fd()
    fd()
   	face(north)
   	findZ(homeZ)
end

--MINING FUNCTIONS--

function checkTurns()
    if turns == "left" then
        turns = 0
    elseif turns == "right" then
        turns = 1
    end
    if turns == 0 then
        move.lt()
        move.fd("d")
        move.lt()
        turns = 1
    else
        move.rt()
        move.fd("d")
        move.rt()
        turns = 0
    end
end

function digLine(length, tunnel)
    for i = 1, length do
        if tunnel == nil then
            checkFull()
            fd("d")
        else
            checkFull()
            turtle.digUp()
            turtle.digDown()
            fd("d")
            turtle.digUp()
            turtle.digDown()
        end
    end
end

function digGrid(length, width, side, tunnel)
    turns = side
    if tunnel == nil then
        for i = 1, width do
            digLine(length - 1)
            checkTurns()
        end
    else
        for i = 1, width do
            digLine(length - 1, "d")
            if i ~= width then
                checkTurns()
            end
        end
    end
end

function digRoom(length, width, height, depth, side)
    findY(depth, "d")
    setTempHome()
    qRows = math.floor(height / 3)
    rRows = height - (qRows * 3)
    for i = 1, qRows do
	    turns = side
        digGrid(length, width, side, "d")
		if i == qRows then
		    tempHomeY = tempHomeY + 2
		else
            tempHomeY = tempHomeY + 3
		end
        returnTempHome()
    end
    for i = 1, rRows do
        digGrid(length, width, side)
        tempHomeY = tempHomeY + 1
        returnTempHome()
    end
end

--USEFUL FUNCTIONS--

function clear()
    term.clear()
    term.setCursorPos(1, 1)
end

function select(slot)
    turtle.select(slot)
   	curSlot = slot
end

function place(slot, dir)
    select(Slot)
   	if dir == "up" or dir =="u" then
	       turtle.placeUp()
   	elseif dir == "down" or dir == "d" then
	       turtle.placeDown()
   	elseif dir == nil then
	       turtle.place()
	   end 
end

function rest(count)
    while count > 0 do
        report("Sl: "..tostring(count).." sec.")
        sleep(1)
        count = count - 1
    end
end

function fill(slot)
    select(slot)
   	while turtle.getItemCount(slot) < 64 do
	       turtle.suck()
   	end
   	for i = 1, 16 do
        select(i)
	       if i == slot then
      		else
	           if turtle.compareTo(slot) then
		              turtle.drop()
         			end
      		end
   	end
end

function emptyFrom(slot)
    for i = slot, 16 do
   	    select(i)
      		turtle.drop()
   	end
end

function unload()
        report("Full.")
        sleep(5)
        setTemp()
      		returnTempHome()
        goHome()
        face(east)
        emptyFrom(1)
        launch()
        returnTempHome()
      		returnTemp()
        select(1)
end

function checkStack(tStack, tNum, altStack)
    select(tStack)
	if turtle.getItemCount(tStack) <= tNum then
	    select(altStack)
    end
end

function checkFull()
    if turtle.getItemCount(16) >= 1 then
	    unload()
		select(1)
	end
end

function checkAll()
    count = 0
    for i = 1, 16 do
        select(i)
        if turtle.getItemCount(i) > 0 then
            break
        end
        count = count + 1
    end
    if count == 16 then
        unload()
    end
end
