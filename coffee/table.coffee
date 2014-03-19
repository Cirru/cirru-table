
Vue = require 'vue'

vm = new Vue
  el: '#app'
  data:
    code: ''
    tree: []
  methods: {}

Vue.component 'cirru-exp',
  template: document.querySelector('#exp')