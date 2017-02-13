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

        return Promise.map(insertion, () => {
            let wall = generateWall(cache);
            cache[table][wall.wall_id]=wall;
            fileStream.write(sqlCmd + " " + table + ` values('${wall.wall_id}','${wall.descr}','${wall.perrmission}','${wall.email}') ;\n`);
        })
        .then(() => {
            //Generate 1 wall per user
            return Promise.map(_.keys(cache.users), (email) => {
                 let wall = generateWall(cache,email);
                cache[table][wall.wall_id]=wall;
                fileStream.write(sqlCmd + " " + table + ` values('${wall.wall_id}','${wall.descr}','${wall.perrmission}','${wall.email}') ;\n`);
       
            })
        })
        .then(() => {
            console.log("Insert wall script generated")
            resolve();
        })

    })
}