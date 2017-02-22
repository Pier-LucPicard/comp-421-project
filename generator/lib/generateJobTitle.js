'use strict'
const titles = require('../data/job_title')

module.exports = () =>  {
  let firstIndex = Math.floor(Math.random() * titles.first.length);
  let lastIndex = Math.floor(Math.random() * titles.last.length);
  return `${titles.first[firstIndex]} ${titles.last[lastIndex]}`
}