/**
 * Only attach these functions is Angular Mocks has already been included.
 */
if(typeof angular.mock !== 'undefined' && angular.mock !== null) {
  window.mockBackend = angular.mock.mockBackend =
  function mockHttpBackend(data, afterEach){
    if( null == afterEach ){
      afterEach = angular.noop;
    }
    inject(function injectMockHttpBackend($httpBackend){
      var status, body;
      for(var path in data){
        body = data[path];
        if (angular.isString(body)) {
          status = 200;
        } else {
          status = body.status;
          body = body.body;
        }
        $httpBackend.whenGET(path).respond(status, body);
      }
      afterEach(function(){
        $httpBackend.verifyNoOutstandingExpectation();
        $httpBackend.verifyNoOutstandingRequest();
      });
    });
  };
}
