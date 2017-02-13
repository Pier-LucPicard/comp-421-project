'use strict';
const _ = require('lodash');
const Promise = require('bluebird');

let generatePartOf = (cache) => {
    let emails = _.keys(cache.users);
    let email = emails[_.random(0, emails.length - 1, false)];
    let convos = _.keys(cache.conversation);
    let convo = convos[_.random(0, convos.length - 1, false)];
    return { convo_id:convo, email:email }
}

module.exports = (cache) => {

    let helper = (cache) => {
        let generated = generatePartOf(cache);
        return cache.partof[generated.email + '-' + generated.convo_id] ?  helper(cache) : generated

    }
    
    return helper(cache);

}