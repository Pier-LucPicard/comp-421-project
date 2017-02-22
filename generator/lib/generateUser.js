'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const chance = require('chance')();


let findLocation = (cache) => {

    let locationCacheKeys = _.keys(cache.location);
    let selectedKey = locationCacheKeys[_.random(0,locationCacheKeys.length -1, false)];
    return cache.location[selectedKey]

}

module.exports = (cache) => {

    let email = generateEmail(cache,'users');
    let location = findLocation(cache);
    let gender = chance.gender();

    return  {
        email: email, 
        first_name:chance.first({gender:gender}), 
        last_name: chance.last(), 
        birthday: chance.birthday().toDateString(),
        password:  chance.word({length: 10}),
        gender: gender.toLowerCase()[0],
        city: location.city,
        country: location.country
    }

}