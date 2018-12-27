let gulp = require('gulp'),
	replace = require('gulp-replace'),
	header = require('gulp.header'),
	babel = require('gulp-babel'),
	livereload = require('gulp-livereload'),
	gulpSequence = require('gulp-sequence'),
	watch = require('gulp-watch'),
	cmd = require('node-cmd'),
	sass = require('gulp-sass'),
	less = require('gulp-less'),
	cssmin = require('gulp-minify-css'),
	plumber = require('gulp-plumber'),
	notify = require('gulp-notify'),
	rename = require("gulp-rename"),
	del = require('del'),
	fs = require('fs'),
	path = require('path'),
	autoprefixer = require('gulp-autoprefixer'),
	uglify = require('gulp-uglify'),
	pump = require('pump'),
	pngquant = require('imagemin-pngquant'),
	htmlmin = require('gulp-htmlmin'),
	imageMin = require('gulp-imagemin');

let lastTime = Date.now();
gulp.task('watch', [], () => {
	livereload.listen()
	setTimeout(() => {
		watch(['solway_necloud_es6/myJs/**'], () => {
			gulp.src(['solway_necloud_es6/myJs/**/*.js', 'solway_necloud_es6/myJs/*.js'])
				.pipe(plumber({ errorHandler: notify.onError("Error: <%= error.message %>") }))
				.pipe(babel({
					"presets": [
						"es2015",
						"stage-0",
						// "minify"
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
						["transform-es2015-classes", { "loose": true }]
					],
					"comments": false,
				}))
				.pipe(gulp.dest('theme/js/dist/'))

			cmd.run(`git add solway_necloud_es6/`)
		})

		watch(['solway_necloud_es6/react/**'], () => {
			gulp.src(['solway_necloud_es6/react/**/*.js', 'solway_necloud_es6/react/*.js'])
				.pipe(plumber({ errorHandler: notify.onError("Error: <%= error.message %>") }))
				.pipe(babel({
					"presets": [
						"es2015",
						"stage-0",
						"react"
					],
					"plugins": [],
					"comments": false,
				}))
				.pipe(gulp.dest('theme/js/dist/'))

			cmd.run(`git add solway_necloud_es6/`)
		})

		watch('scss/**/*.scss', () => {
			fs.readFile(__dirname + "/myConfig.json", (err, data) => {
				if (err) throw err
				setTimeout(() => {
					gulp.src(JSON.parse(data.toString()).compileScss.map(v => `scss/**/${v}.scss`))
						.pipe(sass({ outputStyle: 'compressed' }).on('error', sass.logError))
						.pipe(autoprefixer({
							browsers: ['last 100 versions'],
							cascade: false
						}))
						.pipe(gulp.dest('theme/css/'))

					cmd.run(`git add scss/`)

				}, 500)
			})
		})

		watch('theme/images/**', (file) => {
			if (file.event === 'change') return;
			const absolutePath = file.history[0];
			const relativePath = absolutePath.replace(file.cwd, '').substr(1);
			const fileName = (/([^<>/\\\|:""\*\?]+)\.\w+$/).exec(absolutePath)[0];
			const distPath = relativePath.replace(fileName, '');

			gulp.src(relativePath)
				.pipe(imageMin({ progressive: true }))
				.pipe(gulp.dest(distPath))

		})

		watch('theme/css/**/*.less', () => {
			fs.readFile(__dirname + "/myConfig.json", (err, data) => {
				if (err) throw err
				gulp.src(JSON.parse(data.toString()).compileLess.map(v => `theme/css/**/${v}.less`))
					.pipe(less())
					.pipe(cssmin())
					.pipe(autoprefixer({
						browsers: ['last 100 versions'],
						cascade: false
					}))
					.pipe(gulp.dest('theme/css/'))
			})
		})

		watch(['theme/**', 'tpl/**', '!{theme/css}/**/*.less'], (event) => {
			setTimeout(() => {
				const DateNow = Date.now();
				if (lastTime + 1000 * 60 < DateNow) {
					lastTime = DateNow;
					gulp.src(['login.html'])
						.pipe(replace(/\'\?_=[^d+$]*?\'/g, `'?_=${DateNow}'`))
						.pipe(gulp.dest(''));
				}
				livereload.changed(event.path)
			}, 500);
		})
	}, 5000)
})


gulp.task('openChrome', () => cmd.run('start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://127.0.0.1:8080'))

gulp.task('updateCode', () => {
	// svnUpdate()

	cmd.get(`git pull`, (err, data, stderr) => {
		if (err) return console.log(`git pull error\n`, err, data, stderr)
		console.log('git pull dong', data, stderr)
	})
})

function svnUpdate() {
	return new Promise(resolve => {
		let svnCommitDong = 0
		const svnCommitAdd = () => {
			if (Object.is(++svnCommitDong, 1)) resolve()
		}

		cmd.get(`svn update`, (err, data, stderr) => {

			if (err) return console.log('svn update webapp error :\n\n', err, data, stderr)
			if (data.includes('conflicts:')) return console.log('等等， webapp 文件有冲突，\n', data, '冲突修改后，执行  “gulp commit” 提交代码')
			console.log('webapp svn update dong', data, stderr)
			svnCommitAdd()
		})

	})
}



/****************************************非代理启动************************************** */
gulp.task('start', gulpSequence('updateCode', 'watch', 'openChrome'))


gulp.task('es6Rename', () => {
	gulp.src('solway_necloud_es6/myJs/**/*.js')
		.pipe(rename(path => {
			path.basename += ".js"
			path.extname = ".bak"
		})).pipe(gulp.dest('solway_necloud_es6/myJs/'))
})

gulp.task('es6JsDel', () => {
	setTimeout(() => {
		del(['solway_necloud_es6/myJs/**/*.js']).then(paths => console.log('Deleted files and folders:\n', paths.join('\n')))
	}, 1000);
})

gulp.task('commit', [], async () => {
	await svnUpdate()

	await new Promise(resolve => setTimeout(() => resolve(), 1000))

	cmd.run(`cd theme && svn update && svn add * --force && svn commit -m "auto commit"`)

	cmd.run(`cd tpl && svn add * --force && svn commit -m "auto commit"`)

	cmd.get(`git add . && git commit -m "auto update" && git pull`, (err, data, stderr) => {

		if (err) return console.log(`git pull error\n`, err, data, stderr)
		console.log('git pull dong', data, stderr)

		cmd.run('git push')
	})

	await new Promise(resolve => setTimeout(() => resolve(), 5000))

	cmd.get('svn status', (err, data, stderr) => {
		if (err) return console.log(`svn status error\n`, err, data, stderr)

		console.log(data, stderr)
	})

})


/**
 * 构建 压缩
 */
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
