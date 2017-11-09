const express = require('express'),
    request = require('superagent'),
    timeout = require('connect-timeout'),
    bodyParser = require('body-parser'),
    app = express()

//const { HOST = 'http://114.112.96.220', PORT = '3001' } = process.env
// const { HOST = 'http://172.10.1.11:9999', PORT = '3001' } = process.env
const { HOST = 'http://127.0.0.1:8080', PORT = '3001' } = process.env
const TIME_OUT = 30 * 1e3
app.set('port', PORT)
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(timeout(TIME_OUT))
app.use((req, res, next) => {
    if (!req.timedout) next()
})

app.use('/Login/', (req, res) => {
    const method = req.method.toLowerCase()
    //const sreq = request[method](HOST + req.originalUrl)
    const sreq = request[method](HOST + '/NECloud' + req.originalUrl)
    sreq.header = req.headers
    sreq.header.host = HOST.substr(7)
    sreq.set('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8').send(req.body)
    sreq.end((err, resData) => {
        if (resData && resData.statusCode == 200) {
            if (resData.text) {
                resData.header['set-cookie'] && res.cookie('JSESSIONID', resData.header['set-cookie'][0].split('=')[1].split(';')[0], {httpOnly: true })
                res.set('Content-Type', 'application/json;charset=utf-8')
                res.send(JSON.stringify(resData.body))
            } else {
                res.set('Content-Type', 'image/jpeg;')
                res.send(resData.body)
            }
        }
    })
})

app.use('/NECloud/', (req, res) => {
    const method = req.method.toLowerCase()
    //const sreq = request[method](HOST + req.originalUrl.substr(8))
    const sreq = request[method](HOST + req.originalUrl)
            .set('User-Agent', req.headers['user-agent'])
            .set('Content-Type', 'application/json')
    sreq.header = req.headers
    sreq.header.host = HOST.substr(7)
    if (req.headers['x-requested-with']) res.writeHead(200, {'Content-Type':'application/json;charset=utf-8'})
    else res.writeHead(200, {'Content-Type':'text/html;charset=utf-8'})
    if (method === 'post') sreq.set('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8').send(req.body)
    sreq.pipe(res)
    sreq.on('end', (error, result) => {
        if (error) return console.log(error)
    })
})

app.use('/', express.static('./'))

app.listen(app.get('port'), () => console.log(`server running @${app.get('port')}`))