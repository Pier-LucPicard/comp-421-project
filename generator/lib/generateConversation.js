'use strict';
const _ = require('lodash');
const generateName = require('project-name-generator');
const generateId = require('./generateId')

let gender = ['male', 'female', 'other']

let findLocation = (cache) => {

    let locationCacheKeys = _.keys(cache.location);
    let selectedKey = locationCacheKeys[_.random(0,locationCacheKeys.length -1, false)];
    return cache.location[selectedKey]

}

module.exports = (cache) => {
    let name = generateName()

    return  {
        convo_id: generateId(cache, 'conversation'), 
        name:name.spaced
    }

}