function getMax(filePath)
    data = fs.open(filePath)
    return(#data)
end

function getMaxLen(filePath)
    maxLen = 0
    data = fs.open(filePath)
    maxEntries = getMax()
    for i = 1, maxEntries do
        x = string.len(data.readLine())
		if x > maxLen then
		     maxLen = x
	    end
    end
	return(maxLen)
end

function writeFile(filePath, message)
    data = fs.open(filePath, "w")
    data.write(message)
    data.close()
end

function readFile(filePath)
    data = fs.open(filePath, "r")
    fileData = data.readAll()
    data.close()
	return(fileData)
end