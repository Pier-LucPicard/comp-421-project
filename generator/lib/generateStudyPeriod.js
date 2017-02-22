'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateId = require('./generateId')
const chance = require('chance')();
const generateJobTitle = require('./generateJobTitle');
const data = require('../data/edu_level');

let findEmail = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0, userCacheKeys.length - 1, false)];
    return cache.users[selectedKey].email

}

let findStudyplaceId = (cache) => {

    let schoolCacheKeys = _.keys(cache.school);
    let selectedKey = schoolCacheKeys[_.random(0, schoolCacheKeys.length - 1, false)];
    return cache.school[selectedKey]

}

let generateStudyPeriod = (cache) => {
    let from = chance.date();
    let to = chance.date({ year: from.getFullYear() + _.random(1, 10) })
    return {
        email: findEmail(cache),
        org_id: findStudyplaceId(cache),
        from: from.toDateString(),
        to: to.toDateString(),
        edu_level: data.edu_level[_.random(0, data.edu_level.length - 1, false)]
    }
}


module.exports = (cache) => {

    let helper = (cache) => {
        let g = generateStudyPeriod(cache);
        return cache.studyperiod[g.email + '-' + g.org_id + '-' + g.from + '-' + g.to] ? helper(cache) : g

    }

    return helper(cache);



}