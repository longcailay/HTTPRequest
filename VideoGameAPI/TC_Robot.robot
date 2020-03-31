*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}     http://localhost:8080

*** Test Cases ***
TC1:Return all videos games(GET)
    create session  mysession   ${base_url}
    ${header}=      create dictionary  Accept=application/json
    ${response}=        get request   mysession  /app/videogames    headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}

    #VALIDATIONS
    ${status_code}=     convert to string  ${response.status_code}
    ${content}=     convert to string   ${response.content}
    should be equal  ${status_code}     200

TC2:Add a new video game (POST)
    create session  mysession   ${base_url}
    ${body}=    create dictionary       id=22   name=string22   releaseDate=2020-03-18T09:51:10.626Z  reviewScore=0   category=string   rating=string
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=    post request  mysession     /app/videogames     data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #VALIDATIONS
    ${status_code}=     convert to string  ${response.status_code}
    should be equal  ${status_code}     200

    ${res_body}=    convert to string  ${response.content}
    should contain  ${res_body}     Record Added Successfully

TC3: Return the details of a single game by ID(GET)
    create session  mysession   ${base_url}
    ${header}=      create dictionary  Accept=application/json
    ${response}=        get request   mysession  /app/videogames/3    headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}

    #VALIDATIONS
    ${status_code}=     convert to string  ${response.status_code}
    should be equal  ${status_code}     200

    ${res_body}=    convert to string  ${response.content}
    should contain      ${res_body}     Universal
TC4:Update an existing video game by specifying new body (PUT)
    create session  mysession   ${base_url}
    ${body}=    create dictionary  id=4   name=LongHo44   releaseDate=2020-03-18T09:51:10.626Z  reviewScore=0   category=longho   rating=string
    ${header}=  create dictionary  Content-Type=application/json    Accept=application/json
    ${response}=   put request   mysession     /app/videogames/4   data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #VALIDATIONS
    ${status_code}=     convert to string  ${response.status_code}
    should be equal  ${status_code}     200  ##Cai nay server bi loi

    ${res_body}=    convert to string  ${response.content}
    should contain  ${res_body}     LongHo2

TC5: Deletes a video game by ID (DELETE)
    create session  mysession   ${base_url}
    ${header}=  create dictionary  Accept=application.json
    ${response}=    delete request  mysession    /app/videogames/5

    #VALIDATIONS
    ${status_code}=     convert to string  ${response.status_code}
    should be equal  ${status_code}     200

    ${res_body}=    convert to string  ${response.content}
    should contain  Record Deleted Successfully

