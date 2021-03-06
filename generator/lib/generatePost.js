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

let findWall = (cache) => {

    let wallCacheKeys = _.keys(cache.wall);
    let selectedKey = wallCacheKeys[_.random(0,wallCacheKeys.length -1, false)];
    return cache.wall[selectedKey].wall_id

}


module.exports = (cache) => {


    return  {
        wall_id: findWall(cache), 
        email:  findEmail(cache), 
        date: chance.date().toDateString(),
        text:  chance.paragraph({sentences: _.random(0,2,false)}),
        url: _.random(0,10,false) > 7? chance.url() : '',
    }

}