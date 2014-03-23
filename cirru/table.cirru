
body#app
  textarea#editor
    :v-on "keydown: handleKey"
    :v-model code
  #table
    .root-item
      :v-repeat "item: record"
      .item
        :v-component expression
        :v-with "item: item"