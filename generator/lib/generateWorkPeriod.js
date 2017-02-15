'use strict';
const _ = require('lodash');
const generateEmail = require('./generateEmail');
const generateId = require('./generateId')
const chance = require('chance')();
const generateJobTitle = require('./generateJobTitle')

let findEmail = (cache) => {

    let userCacheKeys = _.keys(cache.users);
    let selectedKey = userCacheKeys[_.random(0, userCacheKeys.length - 1, false)];
    return cache.users[selectedKey].email

}

let findWorkplaceId = (cache) => {

    let workplaceCacheKeys = _.keys(cache.workplace);
    let selectedKey = workplaceCacheKeys[_.random(0, workplaceCacheKeys.length - 1, false)];
    return cache.workplace[selectedKey]

}

let generateWorkplacePeriod = (cache) => {
    return {
        email: findEmail(cache),
        org_id: findWorkplaceId(cache),
        from: chance.date().toDateString(),
        to: chance.date().toDateString(),
        job_title: generateJobTitle()
    }
}


module.exports = (cache) => {

    let helper = (cache) => {
        let g = generateWorkplacePeriod(cache);
        return cache.workperiod[g.email + '-' + g.org_id+'-'+g.from+'-'+g.to] ? helper(cache) : g

    }

    return helper(cache);



}