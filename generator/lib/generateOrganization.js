'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateName = require('project-name-generator');
const generateId = require('./generateId')
const chance = require('chance')();

let gender = ['male', 'female', 'other']

let findLocation = (cache) => {

    let locationCacheKeys = _.keys(cache.location);
    let selectedKey = locationCacheKeys[_.random(0,locationCacheKeys.length -1, false)];
    return cache.location[selectedKey]

}

module.exports = (cache) => {
    let r = () => _.random(0,9,false);
    let name = generateName()
    let email = generateEmail(cache,'users',name.dashed);
    let location = findLocation(cache);
    return  {
        name:_.capitalize(name.spaced), 
        description: chance.sentence() , 
        phone_number: chance.phone(),
        address: chance.address(),
        email: email,
        city: location.city,
        country: location.country
    }

}