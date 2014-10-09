module.exports = (grunt)->

  butt = []
  unless process.env.DEBUG
    if process.env.BAMBOO
      butt = ['PhantomJS']
    else if process.env.TRAVIS
      butt = ['Firefox']
    else
      butt = ['Chrome']

  grunt.config.init
    jshint:
      options:
        jshintrc: '.jshintrc'
      files: [
        'src/**/*.js'
      ]

    coffeelint:
      options:
        grunt.file.readJSON '.coffeelintrc'
      files: [
        'src/**/*.coffee'
        'Gruntfile.coffee'
      ]

    karma:
      client:
        options:
          browsers: butt
          frameworks: [ 'mocha', 'sinon-chai' ]
          reporters: [ 'spec', 'junit', 'coverage' ]
          singleRun: true
          logLevel: 'INFO'
          preprocessors:
            'src/tools/*.js': ['coverage']
            'src/test/*.coffee': ['coffee']
          files: [
              'node_modules/angular-builds/angular.js'
              'node_modules/angular-builds/angular-mocks.js'
              'src/tools/*.js'
              'src/test/*.coffee'
          ]
          junitReporter:
            outputFile: 'build/reports/karma.xml'
          coverageReporter:
            type: 'lcov'
            dir: 'build/reports/coverage/'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask 'lint', [ 'jshint', 'coffeelint' ]
  grunt.registerTask 'default', [ 'lint', 'karma' ]
