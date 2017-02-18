"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateConversation = require('../lib/generateConversation');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =50;




module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert conversation script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let id =1
        return Promise.map(insertion, (tableName) => {
            let conversation = generateConversation(cache);
            conversation.convo_id = id
            cache[table][`${id}`]=conversation;
            fileStream.write(sqlCmd + " " + table + ` values('${id}','${conversation.name}') ;\n`);
            id++
    }).then(() => {
            console.log("Insert conversation script generated")
            resolve();
        })

    })
}