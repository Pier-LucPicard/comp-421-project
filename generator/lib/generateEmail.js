'use strict';
const _ = require('lodash');
const generate = require('project-name-generator');

const emailProvider = require('../data/emailProvider')

let generateEmail = (name) => {
    let provider = `@${emailProvider.provider[_.random(0,emailProvider.provider.length,false)]}.${emailProvider.extention[_.random(0,emailProvider.extention.length,false)]}`
    
    let email = name ?`${name}${provider}` :`${generate().dashed}${provider}`  
    return email;
}

module.exports = (cache, table, name) => {

    let email = generateEmail(name);

    while(cache[table][email]){
        email = generateEmail(name);
    }

    return email;

}