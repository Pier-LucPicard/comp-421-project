"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateUser = require('../lib/generateUser');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =100;




module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert user script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let user = generateUser(cache);
            cache[table][user.email]=user;
            fileStream.write(sqlCmd + " " + table + ` values('${user.email}','${user.first_name}','${user.last_name}','${user.birthday}', '${user.password}','${user.gender}','${user.city}','${user.country}') ;\n`);
        }).then(() => {
            console.log("Insert user script generated")
            resolve();
        })

    })
}