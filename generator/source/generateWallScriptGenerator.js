"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const generateWall = require('../lib/generateWall');

const sqlCmd = "INSERT INTO";

const NUMBER_OF_EXTRA_RECCORD =50;//+ the number of user




module.exports = (fileStream, table, cache) => {

    let insertion =new Array(NUMBER_OF_EXTRA_RECCORD);

    console.log('Insert wall script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')
        let  id = 1

        return Promise.map(insertion, () => {
            let wall = generateWall(cache);
            wall.wall_id = id;
            cache[table][`${id}`]=wall;
            fileStream.write(sqlCmd + " " + table + ` values('${id}', '${wall.descr}','${wall.perrmission}','${wall.email}') ;\n`);
            id++
    })
        .then(() => {
            //Generate 1 wall per user
            return Promise.map(_.keys(cache.users), (email) => {
                 let wall = generateWall(cache,email);
                  wall.wall_id = id;
                cache[table][`${id}`]=wall;
                fileStream.write(sqlCmd + " " + table + ` values('${id}', '${wall.descr}','${wall.perrmission}','${wall.email}') ;\n`);
                id++
            })
        })
        .then(() => {
            console.log("Insert wall script generated")
            resolve();
        })

    })
}