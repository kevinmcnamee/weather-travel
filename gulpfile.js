"use strict";

var gulp = require('gulp');
var browserify = require('browserify'); // bundles the js
var babel = require('babelify');
var source = require('vinyl-source-stream'); // Use conventional test streams with Gulp
var buffer = require('vinyl-buffer'); // Use conventional test streams with Gulp
var concat = require('gulp-concat'); // Concatenates files duh
var lint = require('gulp-eslint'); // Lint js files, including JSX
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');

var config = {
  paths: {
    js: './front_end/**/*.js',
    mainJs: './front_end/main.js',
    dist: './app/assets/javascripts/'
  }
}

gulp.task('build', function () {
  var bundler = browserify('./front_end/main.js', { debug: true }).transform(babel, {presets: ['es2015', 'react', 'stage-2']});

  function rebundle() {
    bundler.bundle()
      .on('error', console.error.bind(console))
      .pipe(source('react-bundle.js'))
      .pipe(buffer())
      .pipe(sourcemaps.init({ loadMaps: true }))
      .pipe(uglify().on('error', console.error.bind(console)))
      .pipe(sourcemaps.write('./'))
      .pipe(gulp.dest(config.paths.dist))
  }

  rebundle();
});

gulp.task('lint', function () {
  return gulp.src(config.paths.js)
        .pipe(lint.format());
});

gulp.task('watch', function () {
  gulp.watch(config.paths.js, ['build', 'lint']);
});

gulp.task('default', ['build', 'lint', 'watch']);
