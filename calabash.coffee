
require('calabash').do 'dev',
  'pkill -f doodle'
  'coffee -o src/ -bcw coffee/'
  'cjsify -w coffee/demo.coffee -o build/build.js -v'
  'doodle index.html build/build.js log:yes'