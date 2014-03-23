
body#app
  textarea#editor
    :v-on "keydown: handleKey"
    :v-model code
  #table