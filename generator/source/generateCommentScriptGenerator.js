"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateComment = require('../lib/generateComment');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =300;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert comment of script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let comment = generateComment(cache);
            cache.comment[comment.cid]=comment;
            fileStream.write(sqlCmd + " " + table + " values('"+comment.cid+"', '"+comment.pid+"', '"+comment.email+"','"+comment.text+"','"+comment.time+"') ;\n");
        }).then(() => {
            console.log("Insert comment of script generated")
            resolve();
        })

    })
}