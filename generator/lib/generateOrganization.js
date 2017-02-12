'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateName = require('project-name-generator');
const generateDate = require('random-date');
const generateId = require('./generateId')
const generateText = require('lorem-ipsum');

let gender = ['male', 'female', 'other']

let findLocation = (cache) => {

    let locationCacheKeys = _.keys(cache.location);
    let selectedKey = locationCacheKeys[_.random(0,locationCacheKeys.length -1, false)];
    return cache.location[selectedKey]

}

module.exports = (cache) => {
    let r = () => _.random(0,9,false);
    let name = generateName().dashed
    let email = generateEmail(cache,'users',name);
    let location = findLocation(cache);
    return  {
        org_id: generateId(cache, 'organization'), 
        name:name, 
        description: generateText({}) , 
        phone_number: `(${r()}${r()}${r()})-${r()}${r()}${r()}-${r()}${r()}${r()}${r()}`,
        address: 'not generated',
        email: email,
        city: location.city,
        country: location.country
    }

}