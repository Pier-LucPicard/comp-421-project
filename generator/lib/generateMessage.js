'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateId = require('./generateId')
const chance = require('chance')();


let findPartOf = (cache) => {

    let partOfCacheKeys = _.keys(cache.partof);
    let selectedKey = partOfCacheKeys[_.random(0,partOfCacheKeys.length -1, false)];
    return cache.partof[selectedKey]

}


module.exports = (cache) => {
    let partof = findPartOf(cache);
    return  {
        msg_id: generateId(cache, 'message'), 
        email: partof.email,
        convo_id: partof.convo_id,
        time: chance.date().toDateString(),
        content:chance.sentence()

    }

}