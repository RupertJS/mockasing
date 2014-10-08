toKeyVal = (attributes, separator = ' ')->
    (
        for key, val of attributes
            if val? then "#{key}='#{val}'" else key
    ).join separator

if angular.mock
    window.render =
    angular.mock.render = (html, data = {})->
        $element = angular.element(html)
        inject ($compile, $rootScope)->
            if data is $rootScope
                mg = 'Please do not use the $rootScope as data for a directive.'
                throw new Error mg
            if data.constructor?.name is 'Scope'
                $scope = data
            else
                $scope = $rootScope.$new()
                $scope[key] = val for key, val of data

            $compile($element)($scope)

            try
                $scope.$digest()
                $element.$scope = $scope
            catch exception
                err = "Exception when rendering #{directive}"
                console.error err, exception
                throw exception
        $element

    window.renderElement =
    angular.mock.renderElement = (tag, data={}, attributes={}, transclude='')->
        attributes = toKeyVal attributes
        string = "<#{tag} #{attributes}>#{transclude}</#{tag}>"
        angular.mock.render(string, data)

    window.renderAttribute =
    angular.mock.renderAttribute = (directive, data, attributes)->
        attributes[directive] = false
        angular.mock.renderElement('div', data, attributes, transclude)
