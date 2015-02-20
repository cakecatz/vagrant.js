# vagrant.js
[![NPM](https://nodei.co/npm/vagrant.js.png?compact=true)](https://nodei.co/npm/vagrant.js/)  

This module is wrapper of vagrant.

**REQUIRED**: installed `vagrant`

## example code

    var vagrant = require("vagrant.js");

    vagrant.status(function(statusArr, stderr){

    });

    vagrant.boxList(function(boxArr, stderr){

    });

    vagrant.boxAdd(boxName, boxUrl, function(boxArr, stderr){

    });

### statusArr  

statusArr is status info object Array.  
Like this.  

    [
      {
        id: "",
        name: "",
        provider: "",
        status: "",
        directory: ""
      },
      ...
    ]

### boxArr  

boxArr is box info object Array.  
Like this.  

    [
      {
        name: "",
        provider: "",
        version: ""
      },
      ...
    ]

## Implemented methods  

`status(function(statusArr, stderr){})`  
`boxList(function(boxArr, stderr){})`  
`boxAdd(boxName, boxUrl, function(){})`  
`boxRemove(boxName, function(stdout, stderr){})`  
`boxdestroy(machineId, function(stdout, stderr){})`  
`up(vagrantfileDir, function(stdout, stderr){})`  
`halt(machineId, function(stdout, stderr){})`  
`suspend(machineId, function(stdout, stderr){})`  
`resume(machineId, function(stdout, stderr){})`  
`provision(machineId, function(stdout, stderr){})`  

*Sorry, vagrant ssh is not supported still :-(*