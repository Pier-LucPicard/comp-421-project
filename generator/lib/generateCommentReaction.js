'use strict';
const _ = require('lodash');
const Promise = require('bluebird');
const data = require('../data/type');

let generateCommentReaction = (cache) => {
    let emails = _.keys(cache.users);
    let email = emails[_.random(0, emails.length - 1, false)];
    let comments = _.keys(cache.comment);
    let comment = comments[_.random(0, comments.length - 1, false)];
    return { cid:comment, email:email, type:data.type[_.random(0, data.type.length - 1, false)] }
}

module.exports = (cache) => {

    let helper = (cache) => {
        let generated = generateCommentReaction(cache);
        return cache.commentreaction[generated.cid + '-' + generated.email] ?  helper(cache) : generated

    }
    
    return helper(cache);

}