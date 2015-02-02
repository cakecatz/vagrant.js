exec = require('child_process').exec;
p = require 'prettyput'

vagrant = {
  status: (callback, outputError)->
    outputError = outputError || false
    exec 'vagrant global-status --prune', (err, stdout, stderr)->
      if outputError
        p.e err
        p.e stderr
      machineStatusList = []
      parsedStatusArr = vagrant._machineStatusParse stdout
      for status in parsedStatusArr
        arr = vagrant._splitWithoutEmpty status, ' '
        machineStatusList.push {
          id: arr[0]
          name: arr[1]
          provider: arr[2]
          status: arr[3]
          directory: arr[4]
        }
      callback machineStatusList

  _machineStatusParse: (text)->
    machineStatusList = text.split "\n"
    if machineStatusList.length <= 6
      p.p "There are not virtual Machines"
      return []
    else
      return machineStatusList.slice 2, -8

  boxList: (callback)->
    outputError = outputError || false
    exec 'vagrant box list --machine-readable', (err, stdout, stderr)->
      if outputError
        p.e err
        p.e stderr
      splitedBoxListText = vagrant._splitWithoutEmpty stdout, '\n'
      boxes = []
      for i in [0...splitedBoxListText.length/3]
        boxes.push
          name: (vagrant._splitWithoutEmpty splitedBoxListText[i*3], ',')[2]
          provider: (vagrant._splitWithoutEmpty splitedBoxListText[i*3 + 1], ',')[2]
          version: (vagrant._splitWithoutEmpty splitedBoxListText[i*3 + 2], ',')[2]
      callback boxes

  destroy: (machineId, callback, outputError)->
    outputError = outputError || false
    exec 'vagrant destroy -f ' + machineId, (err, stdout, stderr)->
      if outputError
        p.e err
        p.e stderr
      p.p stdout

  _splitWithoutEmpty: (text, pattern)->
    preArray = text.split pattern
    newArray = []
    for v in preArray
      if v isnt undefined and v isnt ""
        newArray.push v
    return newArray
}

module.exports = vagrant
