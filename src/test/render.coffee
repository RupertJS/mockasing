describe 'angular.mock.render', ->
  describe 'basic rendering', ->
    it 'renders html with a template', ->
      element = render '<span>Hello, {{ name }}!</span>', {name: 'David'}
      element.text().should.equal 'Hello, David!'

    it 'renders a repeated element into a parent', ->
      tag = 'li'
      data = {letters: ['a', 'b', 'c']}
      attributes = {'ng-repeat': 'letter in letters'}
      transclude = '{{ letter }}'
      parent = angular.element '<ul></ul>'

      element = renderElement tag, data, attributes, transclude, parent

      parent.children().length.should.equal 3
      parent.text().should.equal 'abc'

    it 'rejects $rootScope as a data source', inject ($rootScope)->
      (->render('<span>{{name}}</span>', $rootScope)).should.throw()
