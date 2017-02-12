'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateName = require('random-name');
const generateDate = require('random-date');

let gender = ['male', 'female', 'other']

let findLocation = (cache) => {

    let locationCacheKeys = _.keys(cache.location);
    let selectedKey = locationCacheKeys[_.random(0,locationCacheKeys.length -1, false)];
    return cache.location[selectedKey]

}

module.exports = (cache) => {

    let email = generateEmail(cache,'users');
    let location = findLocation(cache);
    return  {
        email: email, 
        first_name:generateName.first(), 
        last_name: generateName.last() , 
        birthday: new Date(generateDate('-80y')).toDateString(),
        password: 'not generated',
        gender: gender[_.random(0,gender.length-1, false)],
        city: location.city,
        country: location.country
    }

}