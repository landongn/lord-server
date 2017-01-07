'use strict'

var gulp = require('gulp');
var gsass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var babel = require('gulp-babel');
var concat = require('gulp-concat');
var browserify = require('browserify');
var fs = require("fs");

gulp.task('js', function () {
  browserify('./web/static/js/app.js')
    .transform("babelify", {presets: ["es2015"]})
    .bundle()
    .pipe(fs.createWriteStream("./priv/static/js/app.js"));

  browserify('./web/static/js/prototype.js')
    .transform("babelify", {presets: ["es2015"]})
    .bundle()
    .pipe(fs.createWriteStream("./priv/static/js/prototype.js"));

  browserify('./web/static/js/spaceballs.js')
    .transform("babelify", {presets: ["es2015"]})
    .bundle()
    .pipe(fs.createWriteStream("./priv/static/js/spaceballs.js"));
});

gulp.task('vendor', function () {
  return gulp.src('./web/static/vendor/**/*.js')
    .pipe(concat('vendor.js'))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./priv/static/js/'))
});

gulp.task('assets', function () {
  return gulp.src('./web/static/assets/**/*.*')
    .pipe(gulp.dest('./priv/static/'));
});


gulp.task('styles', function () {
  return gulp.src('web/static/css/app.scss')
    .pipe(gsass().on('error', gsass.logError))
    .pipe(gulp.dest('priv/static/css'));
});

gulp.task('gameStyles', function () {
  return gulp.src('web/static/css/game.scss')
    .pipe(gsass().on('error', gsass.logError))
    .pipe(gulp.dest('priv/static/css'));
});

gulp.task('default', ['js', 'vendor', 'assets', 'styles', 'gameStyles', 'dev:watch']);

gulp.task('dev:watch', function () {
  gulp.watch('web/static/css/**/*.scss', ['styles', 'gameStyles']);
  gulp.watch('web/static/js/**/*.js', ['js']);
  gulp.watch('web/static/assets/**/*.*', ['assets'])
});
