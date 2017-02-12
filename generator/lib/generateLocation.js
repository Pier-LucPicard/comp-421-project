'use strict';
const _ = require('lodash');
const countriesToCities = require('../data/countriesToCities');


let generateCountryCityPair = () => {
    let countries = _.keys(countriesToCities);
    let country = countries[_.random(0, countries.length - 1, false)];
    let cities = countriesToCities[country];
    let city = cities[_.random(0, cities.length - 1, false)]
    return { country:_.deburr(country), city:_.deburr(city) }
}

module.exports = (cache) => {

    let generated = generateCountryCityPair();

    while (cache.location[generated.country + '-' + generated.city]) {
        generated = generateCountryCityPair();
    }

    return generated

}