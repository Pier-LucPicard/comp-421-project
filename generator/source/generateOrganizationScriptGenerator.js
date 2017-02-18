"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateOrganization = require('../lib/generateOrganization');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =100;

const type = ['school','workplace'];


module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert organization script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let id = 1;
        return Promise.map(insertion, (tableName) => {
            let organization = generateOrganization(cache);
            organization.org_id = id
            cache[table][`${id}`]=organization;
            let orgType=type[_.random(0,type.length-1)]
            cache[orgType][`${id}`] = id
            fileStream.write(sqlCmd + " " + table + ` values('${id}','${organization.name}','${organization.description}','${organization.phone_number}', '${organization.address}','${organization.email}','${organization.city}','${organization.country}') ;\n`);
            fileStream.write(sqlCmd + " " + orgType + ` values('${id}') ;\n`);
            id++
     }).then(() => {
            console.log("Insert organization script generated")
            resolve();
        })

    })
}