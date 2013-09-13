--GLOBAL VARIABLES--

myId = os.computerID() + 10

--MODEM FUNCTIONS--

--Opens the modem and channels on selected side
function open(channel, side)
    m = peripheral.wrap(side)
	    m.open(channel)
	m.open(myId)
end

--Closes all channels on selected side
function close(side)
    m = peripheral.wrap(side)
	m.closeAll()
end

--PING FUNCTIONS

--Get names of all peripherals attached to this computer
--Returns: table
function ping(side)
    m = peripheral.wrap(side)
    return(m.getNamesRemote())
end

--Get names of all peripherals attached to this computer
--Returns: table
function dnsPing(room, side)
	m = peripheral.wrap(side)
    netTab = m.getNamesRemote()
    netMap = {}
    for i = 1, #netTab do
        name = netTab[i]
        netMap[i] = {}
        perType = string.match(name, '%a+')
        perNum = tonumber(string.match(name, "%d+"))
        netMap[i][1] = netTab[i]
        netMap[i][2] = perType
        netMap[i][3] = room.." "..perType.." "..(perNum + 1)
    end
    return netMap
end

--Get names of specific peripherals attached to this computer
--Returns: table
function dnsPingType(room, request, side)
    m = peripheral.wrap("side")
    oldTab = dnsPing(room, side)
    newTab = {}
    j = 1
    for i = 1, #oldTab do
        newTab[i] = {}
        if oldTab[i][2] == request then
            newTab[j][1] = oldTab[i][1]
            newTab[j][2] = oldTab[i][2]
            newTab[j][3] = oldTab[i][3]
            j = j + 1
        end
    end
    return(newTab)
end

--SEND FUNCTIONS--

--Sends message over specified channel
function send(channel, msg, side)
    open(channel, side)
    m.transmit(channel, myId, msg)
    close(side)
end

--Sends table over specified channel
function sendTable(channel, tableData, side)
    open(channel, side)
	   m.transmit(channel, retCh, textutils.serialize(tableData))
	   close(side)
end

--Sends file over specified channel
function sendCode(channel, fileName, side)
    open(channel, side)
    data = fs.open(fileName, "r")
    message = data.readAll()
    data.close()
    m.transmit(channel, myId, message)
   	close(side)
end

--RECEIVE FUNCTIONS--

--Receives message over specified channel
function receive(channel, side)
    open(channel, side)
   	event, mSide, sendCh, retCh, rMsg, dist = os.pullEvent("modem_message")
   	close(side)
    return(rMsg, retCh)
end
