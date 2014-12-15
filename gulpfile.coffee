gulp = require 'gulp'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
uglify = require 'gulp-uglify'
streamify = require 'gulp-streamify'
source = require 'vinyl-source-stream'
connect = require 'gulp-connect'
prettyHrtime = require 'pretty-hrtime'
nodemon = require 'gulp-nodemon'


env = process.env.NODE_ENV
dest = './assets'

gulp.task 'watch', ['setWatch']

gulp.task 'setWatch', -> global.isWatching = true

gulp.task 'serve', ['watch'], ->
  nodemon(script: 'src/server.coffee')

gulp.task 'default', ['serve']