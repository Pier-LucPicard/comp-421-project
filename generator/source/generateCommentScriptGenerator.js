"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateComment = require('../lib/generateComment');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =450;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert comment of script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let id = 1
        return Promise.map(insertion, (tableName) => {
            let comment = generateComment(cache);
            comment.cid = id
            cache.comment[`${id}`]=comment;
            fileStream.write(sqlCmd + " " + table + " values('"+id+"', '"+comment.pid+"', '"+comment.email+"','"+comment.text+"','"+comment.time+"') ;\n");
            id ++
    }).then(() => {
            console.log("Insert comment of script generated")
            resolve();
        })

    })
}