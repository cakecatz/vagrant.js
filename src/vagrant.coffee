exec = require('child_process').exec;
p = require 'prettyput'

vagrant = {
  status: (callback)->
    exec 'vagrant global-status --prune', (err, stdout, stderr)->
      p.e err
      machineStatusList = []
      parsedStatusArr = vagrant._machineStatusParse stdout
      for status in parsedStatusArr
        arr = vagrant._splitWithoutEmpty status, ' '
        machineStatusList.push {
          id: arr[0]
          name: arr[1]
          provider: arr[2]
          state: arr[3]
          directory: arr[4]
        }
      callback machineStatusList, stderr

  _machineStatusParse: (text)->
    machineStatusList = text.split "\n"
    if machineStatusList.length <= 6
      return []
    else
      return machineStatusList.slice 2, -8

  boxList: (callback)->
    exec 'vagrant box list --machine-readable', (err, stdout, stderr)->
      p.e err
      splitedBoxListText = vagrant._splitWithoutEmpty stdout, '\n'
      boxes = []
      for i in [0...splitedBoxListText.length/3]
        boxes.push
          name: (vagrant._splitWithoutEmpty splitedBoxListText[i*3], ',')[2]
          provider: (vagrant._splitWithoutEmpty splitedBoxListText[i*3 + 1], ',')[2]
          version: (vagrant._splitWithoutEmpty splitedBoxListText[i*3 + 2], ',')[2]
      callback boxes, stderr

  boxAdd: (boxName, boxUrl, callback)->
    exec 'vagrant box add ' + boxName + ' ' + boxUrl, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  boxRemove: (boxName, callback)->
    exec 'vagrant box remove ' + boxName, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  destroy: (machineId, callback)->
    exec 'vagrant destroy -f ' + machineId, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  up: (vagrantfileDir, callback)->
    exec 'VAGRANT_CWD="' + vagrantfileDir + '" vagrant up', (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  halt: (machineId, callback)->
    exec 'vagrant halt -f ' + machineId, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  suspend: (machineId, callback)->
    exec 'vagrant suspend ' + machineId, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  resume: (machineId, callback)->
    exec 'vagrant resume ' + machineId, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  provision: (machineId, callback)->
    exec 'vagrant provision ' + machineId, (err, stdout, stderr)->
      p.e err
      callback stdout, stderr

  _splitWithoutEmpty: (text, pattern)->
    preArray = text.split pattern
    newArray = []
    for v in preArray
      if v isnt undefined and v isnt ""
        newArray.push v
    return newArray
}

module.exports = vagrant
