"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateMessage = require('../lib/generateMessage');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =450;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert message of script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let id = 1;
        return Promise.map(insertion, (tableName) => {
            let message = generateMessage(cache);
            message.msg_id = id
            cache.message[`${id}`]=message;
            fileStream.write(sqlCmd + " " + table + " values('"+id+"' ,'"+message.email+"', '"+message.convo_id+"','"+message.time+"','"+message.content+"') ;\n");
            id++
    }).then(() => {
            console.log("Insert message of script generated")
            resolve();
        })

    })
}