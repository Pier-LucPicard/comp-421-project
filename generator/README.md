
This is a nodejs generator.

This is not a general purpose generator.  It would require a bit more work to make it genreal.

This create random data that are coherent and that are likely to happen.  

For instance once a user is assigned a gender, his first name will be generated accordingly.

The ounce a country is selected than the city is selected and this pair will be a real life valid location.

The email of an organization will contain the organization name in it.

The text is lorem ipsum which is the closes "readable" random text that can be generated.

The birthday of user are in the past and are actual plausible dates.

The url are well formatted.

The phone number conform to NANP for a proper US number.



The insertion script has to run first because it will start the id at 1 and it keeps track of these id in the generation process.  Note that it will never connect to any database.  It only creat a runable PGSQL script with the desired data.

To run the generator

`` npm install ``

`` npm start ``

The CountriesToCitiesJSON data was taken and modify from
https://github.com/David-Haim/CountriesToCitiesJSON/blob/master/countriesToCities.json

For the other module used they were taken from NPM (node package manager) and the name can be found in the package.json
