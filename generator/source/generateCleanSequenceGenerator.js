"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateLocation = require('../lib/generateLocation');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =100;

module.exports = (fileStream, table, cache) => {

    console.log("Clean sequence script generation");

    return new Promise((resolve) => {
    fs.readFile('data/sequence.txt', 'utf8', function (err,data) {
        console.log("Clean sequence script generated");
        fileStream.write("\n"+data+"/n");
        resolve();
    });

})
}