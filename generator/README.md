
This is a nodejs generator.

This is not a general purpose generator.  It would require a bit more work to make it genreal.

This create random data that are coherent and that are likely to happen.  For instance once a user is assigned a gender, his first name will be generated accordingly.

The insertion script has to run first because it will start the id at 1 and it keeps track of these id in the generation process.  Note that it will never connect to any database.  It only creat a runable PGSQL script with the desired data.

To run the generator

`` npm install ``

`` npm start ``

The CountriesToCitiesJSON data was taken and modify from
https://github.com/David-Haim/CountriesToCitiesJSON/blob/master/countriesToCities.json

For the other module used they were taken from NPM (node package manager) and the name can be found in the package.json
