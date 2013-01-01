
{print} = require "util"
{spawn} = require "child_process"

echo = (child) ->
  child.stderr.pipe process.stderr
  child.stdout.pipe process.stdout

split = (str) -> str.split " "
d = __dirname

queue = [
  "jade -O #{d}/page/ -wP #{d}/src/"
  "coffee -o #{d}/page/ -wbc #{d}/src/"
  "livescript -o #{d}/page/ -wbc #{d}/src/"
  "stylus -o #{d}/page/ -w #{d}/src/"
  "doodle #{d}/page/"
]

queue2 = [
  "jade -O #{d}/page/ -wP #{d}/src/"
  "coffee -o #{d}/page/ -wbc #{d}/src/"
  "livescript -o #{d}/page/ -wbc #{d}/src/"
  "stylus -o #{d}/page/ -w #{d}/src/"
]

task "dev", "watch and convert files", ->
  queue.map(split).forEach (array) ->
    echo (spawn array[0], array[1..])

task "page", "watch and convert files", ->
  queue2.map(split).forEach (array) ->
    echo (spawn array[0], array[1..])