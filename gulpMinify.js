let gulp = require('gulp'),
    gulpSequence = require('gulp-sequence'),
    cssmin = require('gulp-minify-css'),
    autoprefixer = require('gulp-autoprefixer'),
    uglify = require('gulp-uglify'),
    pump = require('pump'),
    pngquant = require('imagemin-pngquant'),
    htmlmin = require('gulp-htmlmin'),
    imageMin = require('gulp-imagemin');

/**
 * 构建 压缩
 */
// gulp.task('minify', gulpSequence('copy', 'minifyJs', 'minifyCss', 'minifyImg'))
gulp.task('minify', gulpSequence('copy', 'minifyHtml', 'minifyJs', 'minifyCss', 'minifyImg'))

// 复制 目录
gulp.task('copy', function () {
    gulp.src('theme/**/*')
        .pipe(gulp.dest('theme_compress'))

    gulp.src('vendor/**/*')
        .pipe(gulp.dest('vendor_compress'))

    return gulp.src('tpl/**/*')
        .pipe(gulp.dest('tpl_compress'))
});

//压缩css
gulp.task('minifyCss', function () {
    gulp.src('theme/**/*.css')
        .pipe(autoprefixer({ browsers: ['last 100 versions'], cascade: false }))
        .pipe(cssmin())
        .pipe(gulp.dest('theme_compress'));

    gulp.src('vendor/**/*.css')
        .pipe(autoprefixer({ browsers: ['last 100 versions'], cascade: false }))
        .pipe(cssmin())
        .pipe(gulp.dest('vendor_compress'));

    return gulp.src('tpl/**/*.css')
        .pipe(autoprefixer({ browsers: ['last 100 versions'], cascade: false }))
        .pipe(cssmin())
        .pipe(gulp.dest('tpl_compress'));
});

//压缩js
gulp.task('minifyJs', function (cb) {
    pump([
        gulp.src('theme/**/*.js'),
        uglify({ mangle: false, compress: false }),
        gulp.dest('theme_compress')
    ], function () {
        pump([
            gulp.src('tpl/**/*.js'),
            uglify({ mangle: false, compress: false }),
            gulp.dest('tpl_compress')
        ], function () {
            pump([
                gulp.src('vendor/**/*.js'),
                uglify({ mangle: false, compress: false }),
                gulp.dest('vendor_compress')
            ], cb)
        });
    })
});

//压缩图片
gulp.task('minifyImg', function () {
    return gulp.src('theme/images/**/*')
        .pipe(imageMin({
            use: [pngquant()]
        }))
        .pipe(gulp.dest('theme_compress/images'));
});

gulp.task('minifyHtml', function () {
    var options = {
        removeComments: true,//清除HTML注释
        collapseWhitespace: true,//压缩HTML
        collapseBooleanAttributes: false,//省略布尔属性的值 <input checked="true"/> ==> <input />
        removeEmptyAttributes: false,//删除所有空格作属性值 <input id="" /> ==> <input />
        removeScriptTypeAttributes: true,//删除<script>的type="text/javascript"
        removeStyleLinkTypeAttributes: true,//删除<style>和<link>的type="text/css"
        minifyJS: {
            mangle: false,
            compress: true,
            comments: false
        },//压缩页面JS
        minifyCSS: true, //压缩页面CSS
        ignoreCustomFragments: [
            /\{\{((.|\s)*?)\}\}/g,
            /\sstyle\=\"((.|\s)*?)\"/g,
            /;/g,
        ]
    };
    return gulp.src(['tpl/**/*.html'])
        .pipe(htmlmin(options))
        .pipe(gulp.dest('tpl_compress'));
});