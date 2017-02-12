"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateOrganization = require('../lib/generateOrganization');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =50;




module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert organization script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let organization = generateOrganization(cache);
            cache[table][organization.org_id]=organization;
            fileStream.write(sqlCmd + " " + table + ` values('${organization.org_id}','${organization.name}','${organization.description}','${organization.phone_number}', '${organization.address}','${organization.email}','${organization.city}','${organization.country}') ;\n`);
        }).then(() => {
            console.log("Insert organization script generated")
            resolve();
        })

    })
}