"use strict";
const _ = require('lodash');
const fs = require('fs');
const Promise = require('bluebird');

const createTable = require('./source/createTableScriptGenerator');
const cleanUp = require('./source/cleanUpScriptGenerator');
const insertLocation = require('./source/generateLocationScriptGenerator');

var tables = {
    conversation: { fields: {}, keys: { primary: [] } },
    message: { fields: {}, keys: { primary: [] } },
    comment: { fields: {}, keys: { primary: [] } },
    post: { fields: {}, keys: { primary: [] } },
    wall: { fields: {}, keys: { primary: [] } },
    location: {
        fields: {
            city: "VARCHAR(50) NOT NULL",
            country: "VARCHAR(50) NOT NULL"
        }, keys: { primary: ['city', 'country'] }
    },
    organization: {
        fields: {
            org_id: 'VARCHAR(30) NOT NULL UNIQUE',
            name: 'VARCHAR(20)',
            description: 'VARCHAR(254)',
            phone_number: 'VARCHAR(50)',
            address: 'VARCHAR(50)',
            email: 'VARCHAR(254)',
            city: 'VARCHAR(50)',
            country: 'VARCHAR(50)'
        }, keys: {
            primary: ['org_id'],
            foreign: {
                "city,country": 'location(city, country)',
            }
        }
    },
    school: { 
        fields: {
            org_id: 'VARCHAR(30) NOT NULL UNIQUE'
        },
        keys: { 
            primary: ['org_id'] , 
            foreign:{
                org_id: 'organization(org_id)'
            }
        }
    },
    workplace: { 
        fields: {
            org_id: 'VARCHAR(30) NOT NULL UNIQUE'
        },
        keys: { 
            primary: ['org_id'] , 
            foreign:{
                org_id: 'organization(org_id)'
            }
        }
    },
    workperiod: { fields: {}, keys: { primary: [] } },
    studyperiod: { fields: {}, keys: { primary: [] } },
    commentreaction: { fields: {}, keys: { primary: [] } },
    postreaction: { fields: {}, keys: { primary: [] } },
    follow: { fields: {}, keys: { primary: [] } },
    partof: { fields: {}, keys: { primary: [] } },
    users: {
        fields: {
            email: 'VARCHAR(254) NOT NULL UNIQUE',
            first_name: 'VARCHAR(30)',
            last_name: 'VARCHAR(30)',
            birthday: 'DATE',
            password: 'VARCHAR(30)',
            gender: 'VARCHAR(10)',
            city: 'VARCHAR(50)',
            country: 'VARCHAR(50)',
        },
        keys: {
            primary: ['email'],
            foreign: {
                "city,country": 'location(city, country)',
            }
        },

    }
};


function generate(table, generators, number) {



}

console.log('Set ok')

let fileStream = fs.createWriteStream('../datagen.pgsql');

cleanUp(fileStream, _.keys(tables))
    .then(() => createTable(fileStream, tables))
    .then(() => insertLocation(fileStream, 'location'));