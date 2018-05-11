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
	autoprefixer = require('gulp-autoprefixer')

gulp.task('watch', [], () => {
	livereload.listen()
	setTimeout(() => {
		watch(['solway_necloud_es6/myJs/**'], () => {
			gulp.src(['solway_necloud_es6/myJs/**/*.js', 'solway_necloud_es6/myJs/*.js'])
				.pipe(plumber({ errorHandler: notify.onError("Error: <%= error.message %>") }))
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
							browsers: ['last 2 versions'],
							cascade: false
						}))
						.pipe(gulp.dest('theme/css/'))

					cmd.run(`git add scss/`)

				}, 500)
			})
		})

		watch('theme/css/**/*.less', () => {
			fs.readFile(__dirname + "/myConfig.json", (err, data) => {
				if (err) throw err
				gulp.src(JSON.parse(data.toString()).compileLess.map(v => `theme/css/**/${v}.less`))
					.pipe(less())
					.pipe(cssmin())
					.pipe(autoprefixer({
						browsers: ['last 2 versions'],
						cascade: false
					}))
					.pipe(gulp.dest('theme/css/'))
			})
		})

		watch(['theme/**', 'tpl/**', '!{theme/css}/**/*.less'], (event) => livereload.changed(event.path))
	}, 5000)
})


gulp.task('openChrome', () => cmd.run('start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" http://127.0.0.1:88/login.html'))

gulp.task('updateCode', () => {
	svnUpdate()
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

