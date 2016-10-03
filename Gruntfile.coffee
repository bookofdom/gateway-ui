module.exports = (grunt) ->
  grunt.initConfig
    copy:
      components:
        options:
          process: (content, srcpath) ->
            content.replace /'gateway\/components\/(.*)'/, "'gateway/pods/components/$1/component'"
        files: [
          expand: true
          cwd: 'app/components'
          src: ['**/*.coffee']
          filter: 'isFile'
          rename: (x, filename)->
            componentName = filename.replace '.coffee', ''
            location = "app/pods/components/#{componentName}/component.coffee"
            location
        ]
      templates:
        #options:
        #  process: (content, srcpath) ->
        #    content.replace /'gateway\/components\/(.*)'/, 'gateway/pods/components/$1/component'
        files: [
          expand: true
          cwd: 'app/templates/components'
          src: ['*.hbs']
          filter: 'isFile'
          rename: (x, filename)->
            componentName = filename.replace '.hbs', ''
            location = "app/pods/components/#{componentName}/template.hbs"
            location
        ]

  grunt.loadNpmTasks 'grunt-contrib-copy'
