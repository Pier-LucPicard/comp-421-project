"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateStudyPeriod = require('../lib/generateStudyPeriod');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =150;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert study period script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let g = generateStudyPeriod(cache);
            cache.studyperiod[g.email + '-' + g.org_id+'-'+g.from+'-'+g.to]=g;
            fileStream.write(sqlCmd + " " + table + " values('"+g.email+"', '"+g.org_id+"', '"+g.from+"','"+g.to+"','"+g.edu_level+"') ;\n");
        }).then(() => {
            console.log("Insert study period script generated")
            resolve();
        })

    })
}