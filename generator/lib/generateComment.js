'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateId = require('./generateId')
const chance = require('chance')();

let findEmail = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0,userCacheKeys.length -1, false)];
    return cache.users[selectedKey].email

}

let findPost = (cache) => {

    let postCacheKeys = _.keys(cache.post);
    let selectedKey = postCacheKeys[_.random(0,postCacheKeys.length -1, false)];
    return cache.post[selectedKey].pid

}


module.exports = (cache) => {


    return  {
        cid: generateId(cache, 'comment'), 
        pid: findPost(cache), 
        email:  findEmail(cache), 
        text:  chance.sentence(),
        time: chance.date().toDateString()
    }

}