"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateCommentReaction = require('../lib/generateCommentReaction');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =400;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert comment reaction script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let commentReaction = generateCommentReaction(cache);
            cache.commentreaction[commentReaction.cid+'-'+commentReaction.email]=commentReaction;
            fileStream.write(sqlCmd + " " + table + " values('"+commentReaction.cid+"', '"+commentReaction.email+"', '"+commentReaction.type+"') ;\n");
    }).then(() => {
            console.log("Insert comment reaction script generated")
            resolve();
        })

    })
}