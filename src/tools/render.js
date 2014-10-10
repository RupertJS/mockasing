/**
 * Utility function, to create an HTML Attribute list out of a POJO.
 */
var toKeyVal = function toKeyVal(attributes, separator) {
  'use strict';
  if (null == separator) {
    separator = ' ';
  }
  var _result = [], val;
  for(var key in attributes){
    val = attributes[key];
    if (typeof val !== 'undefined' && val !== null) {
      _result.push('' + key + '=\'' + val + '\'');
    } else {
      _result.push(key);
    }
  }
  return _result.join(separator);
};

/**
 * Only attach these functions is Angular Mocks has already been included.
 */
if(typeof angular.mock !== 'undefined' && angular.mock !== null) {
  window.render =
  /**
   * A mock to consistently render a piece of HTML, with some data. Handles
   * scope creation, $digest management, and exception handling.
   */
  angular.mock.render = function angularMockRender(html, data, parent){
    'use strict';
    if(data == null){
      data = {};
    }
    var $element = angular.element(html);
    if(parent != null && parent.append != null){
      parent.append($element);
    }
    inject(function angularMockRenderExec(
      $compile, $rootScope, $exceptionHandler
    ) {
      if (data === $rootScope) {
        var mg = 'Please do not use the $rootScope as data for a directive.';
        var error = new Error(mg);
        $exceptionHandler(error);
      }

      var $scope;

      // Check if the provided $scope is already an instance of Scope
      var _tmp, _scope = (_tmp = data.constructor) != null ? _tmp.name : '';
      if(_scope === 'Scope') {
        $scope = data;
      } else {
        // create and populate a parent scope for the directive.
        $scope = $rootScope.$new();
        for(var key in data){
          $scope[key] = data[key];
        }
      }

      $compile($element)($scope);  // jshint ignore:line

      try {
        $scope.$digest();
        $element.$scope = $scope;
      } catch( exception ){
        var err = 'Exception when rendering ' + html;
        $exceptionHandler(exception, err);
        throw exception;
      }
    });
    return $element;
  };

  /**
   * Shortcut: Render an element given a tag, some data, the attributes, and any
   * transclusions desired.
   */
  window.renderElement =
  angular.mock.renderElement = function angularMockRenderElement(
    tag, data, attributes, transclude, parent
  ){
    'use strict';
    if(null == data){
      data = {};
    }
    if(null == attributes){
      attributes = {};
    }
    if(null == transclude){
      transclude = '';
    }
    attributes = toKeyVal(attributes);
    var string = '<' +tag+ ' ' +attributes+ '>' +transclude+ '</' + tag + '>';
    return angular.mock.render(string, data, parent);
  };
}
