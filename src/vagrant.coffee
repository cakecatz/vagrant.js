spawn = require('child_process').spawn;
exec = require('child_process').exec;

p = console.log

vagrant = {
  status: (callback)->
    exec 'vagrant global-status --prune', (err, stdout, stderr)->
      p stdout.split "\n"

  _statusParse: (text)->
    p 'hello'
}

module.exports = vagrant
