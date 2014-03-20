
require 'shelljs/make'
fs = require 'fs'
{renderer} = require 'cirru-html'

station = require 'devtools-reloader-station'

station.start()

target.watch = ->
  fs.watch 'cirru/', interval: 200, (type, name) ->
    file = 'cirru/index.cirru'
    render = renderer (cat file), '@filename': file
    render('@filename': file).to 'index.html'
    station.reload 'repo/cirru/table'

  exec 'coffee -o js/ -wbc coffee/', async: yes

  fs.watch 'js/', interval: 200, ->
    exec 'browserify -o build/build.js -d js/main.js', ->
      station.reload 'repo/cirru/table'