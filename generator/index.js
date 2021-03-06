"use strict";
const _ = require('lodash');
const fs = require('fs');
const Promise = require('bluebird');

const createTable = require('./source/createTableScriptGenerator');
const cleanUp = require('./source/cleanUpScriptGenerator');
const insertLocation = require('./source/generateLocationScriptGenerator');
const insertUser = require('./source/generateUsersScriptGenerator');
const insertOrganization = require('./source/generateOrganizationScriptGenerator');
const insertConversation = require('./source/generateConversationScriptGenerator');
const insertWall = require('./source/generateWallScriptGenerator');
const insertPartOf = require('./source/generatePartOfScriptGenerator');
const insertComment = require('./source/generateCommentScriptGenerator');
const insertPost = require('./source/generatePostScriptGenerator');
const insertFollow = require('./source/generateFollowScriptGenerator');
const insertMessage = require('./source/generateMessageScriptGenerator');

const insertCommentReaction = require('./source/generateCommentReactionScriptGenerator');
const insertPostReaction = require('./source/generatePostReactionScriptGenerator');

const insertWorkPeriod = require('./source/generateWorkPeriodGenerator');

const insertStudyPeriod = require('./source/generateStudyPeriodGenerator');

const cleanCreateDatabase = require('./source/generateCleanDatabaseGenerator');
const cleanSequence = require('./source/generateCleanSequenceGenerator');

const tables = require('./tableSchema');



console.log('Set ok')
const init_cache = () => {
    let cache = {};
    _.forEach(_.keys(tables), (key) => {
        cache[key] = {};
    })
    return cache;
}

let cache = init_cache();
let fileStream = fs.createWriteStream('../datagenerated.sql');

cleanCreateDatabase(fileStream, '', cache)
    .then(()=>insertLocation(fileStream, 'location', cache))
    .then(() => insertUser(fileStream, 'users', cache))
    .then(() => insertOrganization(fileStream, 'organization', cache))
    .then(() => insertConversation(fileStream, 'conversation', cache))
    .then(() => insertWall(fileStream, 'wall', cache))
    .then(() => insertPartOf(fileStream, 'partof', cache))
    .then(() => insertPost(fileStream, 'post', cache))
    .then(() => insertComment(fileStream, 'comment', cache))
    .then(() => insertFollow(fileStream, 'follows', cache))
    .then(() => insertMessage(fileStream, 'message', cache))
    .then(() => insertCommentReaction(fileStream, 'commentreaction', cache))
    .then(() => insertPostReaction(fileStream, 'postreaction', cache))
    .then(() => insertWorkPeriod(fileStream, 'workperiod', cache))
    .then(() => insertStudyPeriod(fileStream, 'studyperiod', cache))
    .then(() => cleanSequence(fileStream, '', cache));