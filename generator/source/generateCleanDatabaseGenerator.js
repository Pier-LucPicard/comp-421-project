"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateLocation = require('../lib/generateLocation');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =100;

module.exports = (fileStream, table, cache) => {
    console.log("Drop and create table script generation");

    return new Promise((resolve) => {
            fileStream.write('/* Script generated '+new Date()+'*/\n\n');
    fs.readFile('data/drop.txt', 'utf8', function (err,data) {
        console.log("Drop and create table script generated");
        fileStream.write(data+"/n");
        resolve();
    });

})
}