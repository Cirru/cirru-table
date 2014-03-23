
script#expression
  :type text/x-template
  .name
    :v-model "pretty(item.name)"
    :v-on "click: (extracted = !extracted)"
    :v-class "collapse: !extracted"
  .params
    :v-if "item.params.length > 0"
    :v-show extracted
    .item
      :v-repeat "item: item.params"
      :v-component expression
  .args
    :v-model "joinItems(item.args)"
  .hidden
    :v-if "item.hidden.length > 0"
    :v-show extracted
    .item
      :v-repeat "item: item.hidden"
      :v-component expression
  .ret
    :v-model "shortenRet(item.ret)"