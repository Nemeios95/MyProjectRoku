sub init()
    m.top.functionName = "getJsonFile"
end sub

sub getJsonFile()
    content = {}
    fileContent = ReadAsciiFile(m.top.jsonFilePath)
    jsonObject = ParseJson(fileContent)
    m.top.content = jsonObject
end sub
