require! {
  \gulp
  \browserify
}
source = require \vinyl-source-stream

$ = (require 'gulp-load-plugins')!
$.q = require \q

gulp.task \compile:ls , ->
  dfrd = $.q.defer!
  browserify(
    entries: [ \./src/app.ls ]
    extensions: [\.ls]
    debug: yes
#        cache: {}, packageCache: {}, fullPaths: yes
  )
  .transform [\liveify]
  .transform ['reactify', 'extension':'ls']
  .bundle!
  .pipe source \app.js
  .pipe gulp.dest \./dist/

gulp.task \default , <[ compile:ls ]>