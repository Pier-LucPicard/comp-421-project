"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generatePostReaction = require('../lib/generatePostReaction');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =400;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert post reaction script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let postReaction = generatePostReaction(cache);
            cache.postreaction[postReaction.pid+'-'+postReaction.email]=postReaction;
            fileStream.write(sqlCmd + " " + table + " values('"+postReaction.pid+"', '"+postReaction.email+"', '"+postReaction.type+"') ;\n");
        }).then(() => {
            console.log("Insert post reaction script generated")
            resolve();
        })

    })
}