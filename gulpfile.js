let gulp = require('gulp'),
    replace = require('gulp-replace'),
    header = require('gulp.header'),
    babel = require('gulp-babel'),
    livereload = require('gulp-livereload'),
    gulpSequence = require('gulp-sequence'),
    watch = require('gulp-watch'),
    cmd = require('node-cmd'),
    sass = require('gulp-sass'),
    plumber = require('gulp-plumber'),
    notify = require('gulp-notify'),
    rename = require("gulp-rename"),
    del = require('del')

gulp.task('watch', () => {
  livereload.listen()
  setTimeout(() => {
    watch(['solway_necloud_es6/myJs/**'], () => {
      gulp.src(['solway_necloud_es6/myJs/**/*.js', 'solway_necloud_es6/myJs/*.js'])
          .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
          .pipe(babel({
              "presets": [
                  "es2015",
                  "stage-0"
              ],
              "plugins": [
                  "transform-member-expression-literals",
                  "transform-merge-sibling-variables",
                  "transform-minify-booleans",
                  "transform-property-literals",
                  "transform-simplify-comparison-operators",
                  "transform-undefined-to-void",
                  "transform-jscript",
                  "transform-flow-strip-types",
                  "transform-eval",
                  ["transform-es2015-for-of", { "loose": true }],
                  ["transform-es2015-arrow-functions", { "spec": true }],
                  "array-includes",
                  ["transform-es2015-classes", {"loose": true}]
              ],
              "comments": false,
          }))
          .pipe(gulp.dest('theme/js/dist/'))
    })

    watch('scss/**/*.scss', () => {
      const notCompile = [
        'test',
        'test2',
      ].join()
      setTimeout(() => {
          gulp.src(['scss/**/*.scss', `!scss/**/{${notCompile}}.scss`])
              .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
              .pipe(gulp.dest('theme/css/'))
      }, 500)
    })

    watch(['theme/**', 'tpl/**', '!{theme/css}/**/*.less'], (event) => livereload.changed(event.path) )
  }, 5000)
})

gulp.task('replaceToDev', () => {

  gulp.src(['theme/js/config.router.js'])
    .pipe(replace('theme/', '/theme/'))
    .pipe(replace(`tpl/`, `/NECloud/tpl/`))
    .pipe(replace(`/NECloud/tpl/app.jsp`, `/tpl/app.jsp`))
    .pipe(replace(`templateUrl: /* @ */'/NECloud/tpl/`, `templateUrl: /* @ */'/tpl/`))
    .pipe(gulp.dest('theme/js/'))

  gulp.src(['theme/js/dist/componets.js'])
    .pipe(replace(`var baseUrl = document.getElementById('routerJS').getAttribute('param')`, `var baseUrl = '';`))
    .pipe(gulp.dest('theme/js/dist/'))
    
  gulp.src(['tpl/myBlocks/**']).pipe(gulp.dest('tpl/blocks/'))
    
  gulp.src(['tpl/myApp.jsp'])
    .pipe(rename(path => {
      path.basename = 'app'
      path.extname = ".jsp"
    })).pipe(gulp.dest('tpl/'))
    
  gulp.src(['tpl/publicComponent/*.jsp'])
    .pipe(replace(`<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>`, ``))
    .pipe(replace('${ctx}/vendor/', '/vendor/'))
    .pipe(replace('${ctx}/tpl/', '/tpl/'))
    .pipe(gulp.dest('tpl/publicComponent/'))
})

gulp.task('proxy', () => require('./proxy') )

gulp.task('openChrome', () => cmd.run('start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://127.0.0.1:3001/login.html'))

gulp.task('svnUpdate', () => cmd.run('svn update && cd solway_necloud_es6/myJs && svn update'))



/****************************************开发环境构建************************************** */
gulp.task('dev', gulpSequence('svnUpdate', 'replaceToDev', 'watch', 'proxy', 'openChrome'))




/****************************************生产环境构建************************************** */
// gulp.task('build', gulpSequence('replaceToProduction', 'es6Rename', 'es6JsDel'))
gulp.task('build', gulpSequence('replaceToProduction', 'es6Rename', 'es6JsDel', 'svnCommit', 'delBlocks'))

gulp.task('replaceToProduction', () => {
  gulp.src(['theme/js/config.router.js'])
    .pipe(replace('/theme/', 'theme/'))
    .pipe(replace(`templateUrl: /* @ */'/tpl/`, `templateUrl: /* @ */'tpl/`))
    .pipe(replace(`/NECloud/tpl/`, `tpl/`))
    .pipe(gulp.dest('theme/js/'))

  gulp.src(['theme/js/dist/componets.js'])
    .pipe(replace(`var baseUrl = '';`, `var baseUrl = document.getElementById('routerJS').getAttribute('param')`))
    .pipe(gulp.dest('theme/js/dist/'))

  gulp.src(['tpl/publicComponent/*.jsp'])
    .pipe(replace('/vendor/', '${ctx}/vendor/'))
    .pipe(replace('/tpl/', '${ctx}/tpl/'))
    .pipe(header(` charset=UTF-8" pageEncoding="UTF-8"%>`))
    .pipe(header(`<%@ page language="java" contentType="text/html;`))
    .pipe(gulp.dest('tpl/publicComponent/'))

  del(['tpl/app.jsp'])
})

gulp.task('es6Rename', () => {
  gulp.src('solway_necloud_es6/myJs/**/*.js')
    .pipe(rename(path => {
      path.basename += ".js"
      path.extname = ".bak"
    }))
    .pipe(gulp.dest('solway_necloud_es6/myJs/'))
})

gulp.task('es6JsDel', () => del(['solway_necloud_es6/myJs/**/*.js']).then(paths => console.log('Deleted files and folders:\n', paths.join('\n'))))

gulp.task('delBlocks', () => del(['tpl/blocks/**']).then(paths => cmd.run('svn update')))

gulp.task('svnCommit', () => cmd.run('svn update' 
  + ' && cd theme && svn add * --force && svn commit -m ""'
  // + ' && cd ../tpl && svn add * --force && svn commit -m ""'
  + ' && cd ../solway_necloud_es6/myJs && svn update && svn add * --force && svn commit -m ""'))
