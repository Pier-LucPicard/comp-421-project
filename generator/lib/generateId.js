'use strict';
const _ = require('lodash');
const shortid = require('shortid');


module.exports = (cache, table) => {

    let generatedId = shortid.generate();

    while(cache[table][generatedId]){
        generatedId = shortid.generate();
    }

    return generatedId;

}