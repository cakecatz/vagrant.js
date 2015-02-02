vagrant = require './vagrant'
p = console.log

vagrant.status (data)->
  p data
