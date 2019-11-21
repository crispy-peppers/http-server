#!/usr/bin/env node
const fs = require('fs');
const execSync = require('child_process').execSync;

var text = fs.readFileSync('public/index.html','utf8')
console.log (text)


// import { execSync } from 'child_process';  // replace ^ if using ES modules
output = '/sbin/ifconfig eth0 | grep \'inet addr\' | cut -d: -f2 | awk \'{print $1}\''
output = execSync(output, { encoding: 'utf-8' });  // the default is 'buffer'
output = '<h1>' + 'Internal IP: ' + output + '<h1>'
text = text.replace('<h1>Serving up static files like they were turtles strapped to rockets.</h1>', output) //output: 'A D C'
console.log('Output was: %s', output);

fs.writeFile("public/test.html", text, function(err) {

    if(err) {
        return console.log(err);
    }

    console.log("The file was saved!");
});
