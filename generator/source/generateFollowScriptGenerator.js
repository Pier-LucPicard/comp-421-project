"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateFollow = require('../lib/generateFollow');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_RECCORD =200;

module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_RECCORD);

    console.log('Insert follow script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(insertion, (tableName) => {
            let follow = generateFollow(cache);
            cache.follow[follow.follower+'-'+follow.followed_by]=follow;
            fileStream.write(sqlCmd + " " + table + " values('"+follow.follower+"', '"+follow.followed_by+"', '"+follow.since+"') ;\n");
        }).then(() => {
            console.log("Insert follow script generated")
            resolve();
        })

    })
}