"use strict";

const Promise = require('bluebird');

const sqlCmd = "DROP TABLE";

module.exports = (fileStream, tableNames) => {
    console.log('Clean up script generation');

    return new Promise((resolve) => {
        fileStream.write('/* Script generated '+new Date()+'*/\n\n')

        return Promise.map(tableNames, (tableName) => {
            return fileStream.write(sqlCmd + " " + tableName + ' CASCADE ;\n');
        },{concurrency: 1}).then(() => {
            console.log("Clean up script generated")
            resolve();
        })

    })

}
