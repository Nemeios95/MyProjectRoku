
sub init()

    m.constants = {

        baseUrl: "https://api.themoviedb.org/3/search/movie?api_key="
        'baseUrl: "https://api.themoviedb.org/3/trending/all/week?api_key="
        imageUrl: "https://image.tmdb.org/t/p/w500"
        apiKey: "36a9cae990eeb96ca2cabae29557f869"
        searchPart: "&query="

    }
    m.top.functionName = "initHttpTask"
end sub

sub initHttpTask()
    url = m.constants.baseUrl + m.constants.apiKey + m.constants.searchPart
    'url =  "https://pokeapi.co/api/v2/pokemon/charmander"
    'stop
    'handle request
    'stop
    urlTransfer = createObject("roUrlTransfer")
    urlTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
    urlTransfer.initClientCertificates()
    urlTransfer.setUrl(m.url)
    urlTransfer.setMessagePort(m.port)
    
    handleResponse(urlTransfer.getToString())
end sub

sub handleResponse(body)
    data = parseJson(body)
    results = data.results
    
    rows = 4
    cols = 5

    content = createObject("roSGNode", "ContentNode")
    for j = 0 to rows - 1
        rowContent = content.createChild("ContentNode")
        for i = 0 to cols - 1
            idx = j * cols + i
            result = results[idx]
            'stop
            itemContent = rowContent.createChild("ContentNode")
            
            itemContent.title = result.title
            itemContent.description = result.overview
            itemContent.id = result.id
            if result.poster_path <> invalid and result.poster_path <> ""
            itemContent.fhdPosterUrl = m.constants.imageUrl + result.poster_path
            end if
        end for
    end for

    rowChildren = content.getChildren(-1, 0)
    itemChildren = rowChildren[0].getChildren(-1, 0)
    print rowChildren, itemChildren
    
    response = {}
    response.content = content
    m.top.response = response
end sub

sub onTermChanged()
    term = m.top.term
    if term <> invalid and term <> "" then
        m.url = m.constants.baseUrl + m.constants.apiKey + m.constants.searchPart + term
    end if
    'stop
end sub