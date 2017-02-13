'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateName = require('random-name');
const generateDate = require('random-date');
const generateId = require('./generateId')
const generateText = require('lorem-ipsum');
const permission = require('../data/permission').permission;

let findEmail = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0,userCacheKeys.length -1, false)];
    return cache.users[selectedKey].email

}

module.exports = (cache, email) => {


    return  {
        wall_id: generateId(cache ,'wall'), 
        descr:generateText(), 
        perrmission: permission[_.random(0,permission.length-1, false)], 
        email: email? email : findEmail(cache)
    }

}