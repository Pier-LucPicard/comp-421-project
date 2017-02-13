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

        return Promise.map(insertion, (tableName) => {
            let conversation = generateConversation(cache);
            cache[table][conversation.convo_id]=conversation;
            fileStream.write(sqlCmd + " " + table + ` values('${conversation.convo_id}','${conversation.name}') ;\n`);
        }).then(() => {
            console.log("Insert conversation script generated")
            resolve();
        })

    })
}