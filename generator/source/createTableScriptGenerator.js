"use strict";
const fs = require('fs');
const Promise = require('bluebird');
const _ = require('lodash');

const sqlCmd = "CREATE TABLE";


module.exports = (fileStream, tableSchema) => {
    console.log('Create table script generation');


    return new Promise((resolve) => {
        fileStream.write('/* Script generated ' + new Date() + '*/\n\n')

        return Promise.map(_.keys(tableSchema), (tableName) => {
            let first = true;
            let command = ''
            return new Promise((resolve) => {
                command = command + '' + sqlCmd + " " + tableName + '(';

                return Promise.map(_.keys(tableSchema[tableName].fields), (field) => {
                    if (first) {
                        first = false;
                        command = command + '' + field + ' ' + tableSchema[tableName].fields[field] + '';
                    } else {
                        command = command + ', ' + field + ' ' + tableSchema[tableName].fields[field] + '';
                    }
                })
                    .then(() => {
                        command = command + ', PRIMARY KEY (';
                        first = true;
                        _.map(tableSchema[tableName].keys.primary, (key) => {
                            if (first) {
                                command = command + '' + key
                                first = false;
                            } else {
                                command = command + ', ' + key
                            }
                        });
                            command = command + ')'
                            return command
                    })
                    .then(() => {

                         return Promise.map(_.keys(tableSchema[tableName].keys.foreign), (key) => {
                            command = command + ", FOREIGN KEY (" + key + ") REFERENCES "+ tableSchema[tableName].keys.foreign[key]
                        })

                    })
                    .then(() => {
                        fileStream.write(command + ');\n \\d '+tableName+';\n');
                        resolve();
                    })
            })



        }).then(() => {
            console.log("Create table script generated")
            resolve();
        })

    })

}