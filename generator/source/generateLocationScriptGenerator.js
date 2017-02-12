"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateLocation = require('../lib/generateLocation');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =50;

module.exports = (fileStream, table) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert location script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let cache = {};
        return Promise.map(insertion, (tableName) => {
            let location = generateLocation(cache);
            cache[location.country+'-'+location.city]=location;
            fileStream.write(sqlCmd + " " + table + " values('"+location.country+"', '"+location.city+"') ;\n");
        }).then(() => {
            console.log("Clean up script generated")
            resolve();
        })

    })
}