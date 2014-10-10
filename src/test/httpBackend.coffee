describe 'angular.mock.httpBackend', ->
  describe 'basic backend data', ->
    it 'stores and retrieves simple endpoints', inject ($http, $httpBackend)->
      fizzbuzz =
        fizz: 3
        buzz: 5
        fizzbuzz: 15
      httpBackend { '/foo': JSON.stringify fizzbuzz }
      $http.get('/foo').success (data)->
        data.should.deep.equal fizzbuzz, 'returns sample data.'
      $httpBackend.flush()
