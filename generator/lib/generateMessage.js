'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateName = require('project-name-generator');
const generateDate = require('random-date');
const generateId = require('./generateId')
const generateText = require('lorem-ipsum');

let gender = ['male', 'female', 'other']

let findEmail = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0,userCacheKeys.length -1, false)];
    return cache.users[selectedKey]

}


let findConversation = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0,userCacheKeys.length -1, false)];
    return cache.users[selectedKey]

}

module.exports = (cache) => {
    let r = () => _.random(0,9,false);
    let name = generateName()
    let location = findLocation(cache);
    return  {
        msg_id: generateId(cache, 'message'), 
        email: findEmail()
        convo_id
        time:
        content:generateText({})

    }

}