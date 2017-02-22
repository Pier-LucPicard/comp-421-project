"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateWorkPeriod = require('../lib/generateWorkPeriod');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =100;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert work period script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let g = generateWorkPeriod(cache);
            cache.workperiod[g.email + '-' + g.org_id+'-'+g.from+'-'+g.to]=g;
            fileStream.write(sqlCmd + " " + table + " values('"+g.email+"', '"+g.org_id+"', '"+g.from+"','"+g.to+"','"+g.job_title+"') ;\n");
        }).then(() => {
            console.log("Insert work period script generated")
            resolve();
        })

    })
}