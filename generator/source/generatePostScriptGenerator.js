"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generatePost = require('../lib/generatePost');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =150;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert post of script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let id = 1
        return Promise.map(insertion, (tableName) => {
            let post = generatePost(cache);
            post.pid = id
            cache.post[`${id}`]=post;
            fileStream.write(sqlCmd + " " + table + " values('"+id+"', '"+post.wall_id+"', '"+post.email+"','"+post.date+"','"+post.text+"','"+post.url+"') ;\n");
            id++
    }).then(() => {
            console.log("Insert post of script generated")
            resolve();
        })

    })
}