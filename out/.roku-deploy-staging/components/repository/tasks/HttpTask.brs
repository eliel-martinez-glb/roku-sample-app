sub init()
    m.top.id = "HttpTask"
    m.top.functionName = "startHttpTask"

    m.port = createObject("roMessagePort")
    m.top.observeField("request", m.port)

    m.jobs = {}
end sub

sub startHttpTask()
    while true
        event = wait(0, m.port)
        eventType = type(event)

        if eventType = "roSGNodeEvent"
            handleHttpRequest(event)
        else if eventType = "roUrlEvent"
            handleHttpResponse(event)
        end if
    end while
end sub

sub handleHttpRequest(event as Object)
    request = event.getData()
    httpTransfer = createObject("roUrlTransfer")
    url = request.url

    print "HttpTask:handleHttpRequest:url= " + url

    if request.queryParams <> invalid
        url += createQueryString(request.queryParams, true)
    end if

    if request.url.left(6) = "https:"
        httpTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
        httpTransfer.initClientCertificates()
    end if

    httpTransfer.enableEncodings(true)
    httpTransfer.retainBodyOnError(true)
    httpTransfer.setRequest(request.method)
    httpTransfer.setUrl(url)
    httpTransfer.setPort(m.port)
    httpTransfer.setHeaders(request.headers)

    reqMethod = request.method
    success = false

    if reqMethod = "GET" or reqMethod = "DELETE"
        success = httpTransfer.asyncGetToString()
    else if reqMethod = "POST" or reqMethod = "PUT"
        success = httpTransfer.asyncPostFromString(request.data)
    end if

    if success
        print "========== HttpTask:handleHttpRequest:success ======= "
        reqID = httpTransfer.getIdentity().toStr()
        job = {httpTransfer: httpTransfer, request: request}
        m.jobs[reqID] = job
    else
        print "========== HttpTask:handleHttpRequest:error ======= "
        error = {error: true, code: 10, data: invalid, request: request, msg: "Failed to create request for : " + request.url}
        job.request.httpResponse.response = createHttpResponseModel(error) 'Inform the controller
    end if
end sub

sub handleHttpResponse(event as Object)
    transferComplete = (event.getInt() = 1)
    if transferComplete
        code = event.getResponseCode()
        identity = event.GetSourceIdentity()
        job = m.jobs.Lookup(identity.toStr())
        if code >= 200 and code < 300 and job <> invalid
            body = event.GetString()
            if body <> invalid AND body <> ""
                data = ParseJson(body)
            else
                data = {}
            end if
            model = convertToDataModel(data, job.request.modelType)
            response = {error: false, code: code, data: model, request: job.request, msg: ""}
            print "========== HttpTask:handleHttpResponse:success ======= "

            job.request.httpResponse.response = createHttpResponseModel(response)
        else
            print "========== HttpTask:handleHttpResponse:error ======= "
            error = {error: true, code: code, data: invalid, request: job.request, msg: event.GetFailureReason()}
            'm.top.response = createHttpResponseModel(error) 'Inform the repository for possible reauth flow
            job.request.httpResponse.response = createHttpResponseModel(error)
        end if

        m.jobs.Delete(identity.toStr())
    end if
end sub

function createHttpResponseModel(response as Object) as Object
    responseModel = createObject("roSGNode", "HttpResponseModel")
    responseModel.errorStatus = response.error
    responseModel.code = response.code
    responseModel.data = response.data
    responseModel.msg = response.msg
    responseModel.request = response.request

    return responseModel
end function

function convertToDataModel(data as Object, modelType as String) as Object
    model = CreateObject("roSGNode", modelType)
  
    if model = invalid
        model = CreateObject("roSGNode", "BaseModel")
    end if
  
    model.callfunc("parseData", data)
  
    return model
end function

function createQueryString(data as Object, encodeData = false as Boolean, addQuestionSymbol = true as Boolean) as String
    if addQuestionSymbol
        queryString = "?"
    else
        queryString = ""
    end if

    index = 0
    dataCount = data.Count()

    for each key in data
        value = data[key]

        if type(value) = "roInteger"
            value = value.toStr()
        end if

        if encodeData
            value = value.toStr().encodeUriComponent()
        end if

        index += 1

        queryString = queryString + key + "=" + value
        if index <> dataCount
            queryString = queryString + "&"
        end if

    end for

    return queryString
end function