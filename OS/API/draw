--GLOBAL VARIABLES--

x, y = term.getSize()

--Colours
white = 1
orange = 2
magenta = 4
lightBlue = 8
yellow = 16
lime = 32
pink = 64
grey = 128
lightGrey = 256
cyan = 512
purple = 1024
blue = 2048
brown = 4096
green = 8192
red = 16384
black = 32768

--TEXT FUNCTIONS--

function writeText(tX, tY, bCol, tCol, text)
    term.setCursorPos(tX, tY)
    term.setBackgroundColor(bCol)
    term.setTextColor(tCol)
    write(text)
end

function centerText(stX, maX, tY, bCol, tCol, text)
    boundry = maX - stX
    width = (boundry / 2) - (string.len(text) / 2)
    writeText(width + stX, tY, bCol, tCol, text)
end

--DRAW FUNCTIONS--

function box(stX, stY, maX, maY, color)
    term.setBackgroundColor(color)
    for i = stY, maY do
        term.setCursorPos(stX, i)
        for j = stX, maX do
            write(" ")
        end
    end
end

function button(xPos, yPos, sizeX, sizeY, bCol, tCol, text) --Needs writing
    box(xPos, xPos + sizeX, yPos, yPos + sizeY, bCol)
	midLine = yPos + (sizeY / 2)
	centerText(xPos, xPos + sizeX, midLine, bCol, tCol, text)
end

function window(sizeX, sizeY, bCol, hCol, tCol, header)
    fakeScreen()
    height = (y / 2) - (sizeY / 2)
    width = (x / 2) - (sizeX / 2)
    box(width, height, (width + sizeX), (height + sizeY), bCol)
    box(width, height, (width + sizeX), height, hCol)
    writeText((width + sizeX), height, bCol, tCol, "X")
    writeText(width + 1, height, hCol, tCol, header)
end

function dataWindow(bCol, hCol, tCol, header)
    fakeScreen()
    box(1, 1, x, y-1, bCol)
    box(1, 1, x, 1, hCol)
    writeText(2, 1, hCol, tCol, header)
    writeText(x, 1, bCol, tCol, "X")
    writeText(2, 2, bCol, tCol, "File Edit Help")
    box(2, 3, x-1, y-2, 1)
    term.setCursorPos(3, 3)
end

function serialize(data, header, bCol, hCol, tCol)
    table = textutils.unserialize(data)
    dataWindow(bCol, hCol, tCol, header)
    term.setBackgroundColor(white)
    term.setTextColor(black)
    yPos = 3
    for i = 1, #table do
        print(table[i][3])
        yPos = yPos + 1
        term.setCursorPos(3, yPos)
    end
end

function optionBox(header, mainText, opt1, opt2)
    fakeScreen()
    boxHeight = 5
    centerY = 12
    if opt1 == nil then
        opt1 = "Ok"
        opt2 = false
    elseif opt2 == nil then
        opt2 = false
    end
    width = string.len(mainText) + 2
    if not opt2 then
        optBoxes = string.len(opt1)
    else
        optBoxes = string.len(opt1) + string.len(opt2)
    end
    if optBoxes > width then
        width = optBoxes
    end
    window(width, boxHeight, lightGrey, magenta, black, header)
    centerText(1, x, (centerY - 2), lightGrey, black, mainText)
    if not opt2 then
        optWidth = (x / 2) - (string.len(opt1) / 2)
        writeText(optWidth, centerY, magenta, black, opt1)
    else
        optWidth = (string.len(opt1) + string.len(opt2) + 3) / 2
        writeText(width, centerY, magenta, black, opt1)
        newX = (width + string.len(opt1)) + 1
        writeText(newX, centerY, magenta, black, opt2)
    end
    opt1Size = string.len(opt1)
    if opt2 then
        opt2Size = string.len(opt2)
    end
    clickTrue = false
    repeat
        event, button, cX, cY = os.pullEvent()
        if event == "mouse_click" then
            --writeText(1, 1, black, white, optWidth.." "..opt1Size)
            if not opt2 then
                if cX >= optWidth and cX <= (optWidth + opt1Size) then
                    if cY == centerY and button == 1 then
                        click = "button1"
                        clickTrue = true
                    end
                end
            else
                if cX >= width and cX <= (width + opt1Size) then
                    if cY == centerY and button == 1 then
                        click = "button1"
                        clickTrue = true
                    end
                end
                if cX >= newX and cX <= (newX + opt2Size) then
                    if cY == centerY and button == 1 then
                        click = "button2"
                        clickTrue = true
                    end
                end
            end
        end
    until clickTrue == true
    return(click)
end

function inputBox(header)
    fakeScreen()
    window(40, 4, lightGrey, magenta, black, header)
    box(((x/2)-19), ((y/2)+1), ((x/2)+19), ((y/2)+1), white)
    term.setCursorPos(((x/2)-19), ((y/2)+1))
end

--GRAPH FUNCTIONS--

--Draws a verticle bar chart
function bar100(startX, startY, width, height, 
currValue, maxValue, barCol, bckCol, fntCol, label)

    barSeg = "_"
    barLbl = string.sub(label, 1, math.min(width, string.len(label)))
    barPer = currValue / maxValue
    barSegs = round(height * barPer, 0)
    bckSegs = height - barSegs
    
    for i = 2, width do
        barSeg = barSeg.." "
    end
    
    terminal.centerText(startX, startX + width, 
    startY + 1, black, white, barLbl)
    
    for j = 0, barSegs - 1 do
        terminal.writeText(startX, startY - j, 
        barCol, fntCol, barSeg)
    end
    
    for k = 0, bckSegs - 1 do
        terminal.writeText(startX, 
        (startY - barSegs) - k, bckCol, fntCol,
        barSeg)
    end
    
end

--UTILITY FUNCTIONS--

function fakeScreen()
    bg = paintutils.loadImage("OS/Artwork/Background")
    paintutils.drawImage(bg, 1, 1)
    box(1, x, y, y, lightGrey)
    writeText(1, y, lightGrey, white, "Start")
end

--Rounds 'num' to 'dec' decimal places
function round(num, dec)
    mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end
