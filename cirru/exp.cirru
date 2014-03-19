template#exp
  p
    :v-model func
  .raw-args
    span
      :v-repeat rawArgs
      :v-model $value
  .arg-exps
    span
      :v-repeat argExps
      :v-model $value

  .arg-results
    span
      :v-repeat argResults
      :v-model $value