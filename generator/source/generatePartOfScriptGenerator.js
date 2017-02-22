"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generatePartOf = require('../lib/generatePartOf');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =150;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert part of script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let partof = generatePartOf(cache);
            cache.partof[partof.email+'-'+partof.convo_id]=partof;
            fileStream.write(sqlCmd + " " + table + " values('"+partof.email+"', '"+partof.convo_id+"') ;\n");
        }).then(() => {
            console.log("Insert part of script generated")
            resolve();
        })

    })
}