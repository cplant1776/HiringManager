global class PQ_RequestResponseMock implements HttpCalloutMock{
	
    private static final String MockBody = '[{"_id":"5a6ce86e2af929789500e7e4","sr":"Ra\u010dunarska nauka se ti\u010de ra\u010dunara koliko i astronomija teleskopa.","en":"Computer Science is no more about computers than astronomy is about telescopes.","author":"Edsger W. Dijkstra","rating":4.2,"id":"5a6ce86e2af929789500e7e4"},{"_id":"5a6ce86e2af929789500e7d7","sr":"Jednostavnost je preduslov za pouzdanost.","en":"Simplicity is prerequisite for reliability.","author":"Edsger W. Dijkstra","id":"5a6ce86e2af929789500e7d7"},{"_id":"5a6ce86d2af929789500e7ca","sr":"Najve\u0107i izazov za programera je da se ne zbuni pred kompleksno\u0161\u0107u sopstvene tvorevine.","en":"The computing scientist\u2019s main challenge is not to get confused by the complexities of his own making.","author":"Edsger W. Dijkstra","rating":4,"id":"5a6ce86d2af929789500e7ca"},{"_id":"5a6ce86f2af929789500e7f3","sr":"Ako je debagovanje proces uklanjanja bagova, onda programiranje mora biti proces njihovog umetanja.","en":"If debugging is the process of removing software bugs, then programming must be the process of putting them in.","author":"Edsger W. Dijkstra","rating":4.7,"id":"5a6ce86f2af929789500e7f3"}]';
    
    global HttpResponse respond(HttpRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(MockBody);
        response.setStatusCode(200);
        return response; 
    } 
    
}