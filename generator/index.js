"use strict";
const _ = require('lodash');
const fs = require('fs');
const Promise = require('bluebird');

const createTable = require('./source/createTableScriptGenerator');
const cleanUp = require('./source/cleanUpScriptGenerator');
const insertLocation = require('./source/generateLocationScriptGenerator');
const insertUser = require('./source/generateUsersScriptGenerator');
const insertOrganization= require('./source/generateOrganizationScriptGenerator');
const insertConversation = require('./source/generateConversationScriptGenerator');
const insertWall = require('./source/generateWallScriptGenerator');
const insertPartOf = require('./source/generatePartOfScriptGenerator');
const insertComment = require('./source/generateCommentScriptGenerator');
const insertPost = require('./source/generatePostScriptGenerator');

const tables = require('./tableSchema');



console.log('Set ok')

let cache = { location: {}, users:{}, organization:{}, conversation:{}, wall:{},partof:{}, post:{}, comment:{} };

let fileStream = fs.createWriteStream('../datagen.pgsql');

cleanUp(fileStream, _.keys(tables))
    .then(() => createTable(fileStream, tables))
    .then(() => insertLocation(fileStream, 'location', cache))
    .then(() => insertUser(fileStream, 'users', cache))
    .then(() => insertOrganization(fileStream, 'organization', cache))
    .then(() => insertConversation(fileStream, 'conversation', cache))
    .then(() => insertWall(fileStream, 'wall', cache))
    .then(() => insertPartOf(fileStream,'partof',cache))
    .then(() => insertPost(fileStream,'post',cache))
    .then(() => insertComment(fileStream,'comment',cache));