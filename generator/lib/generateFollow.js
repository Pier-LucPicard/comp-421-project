'use strict';
const _ = require('lodash');
const Promise = require('bluebird');
const chance = require('chance')();

let generateFollow = (cache) => {
    let emails = _.keys(cache.users);
    let email = emails[_.random(0, emails.length - 1, false)];
    _.remove(emails,(e) => {return e===email});
    let followed_by = emails[_.random(0, emails.length - 1, false)];
    return { followed_by:followed_by, follower:email, since:chance.date().toDateString() }
}

module.exports = (cache) => {

    let helper = (cache) => {
        let generated = generateFollow(cache);
        return cache.follow[generated.follower + '-' + generated.followed_by] ?  helper(cache) : generated

    }
    
    return helper(cache);

}