@isTest
global with sharing class ExternalSystemServiceMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}');
        response.setStatusCode(201);
        return response; 
    }
}

   